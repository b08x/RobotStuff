#!/usr/bin/env ruby

require 'shellwords'
require 'clipboard'
require 'tty-command'
require 'tty-reader'


# Class that represents the transcription command
class TranscribeCommand
  TEMP_FILE_PATH = "/tmp/#{SecureRandom.uuid}.wav".freeze
  JACK_CAPTURE = TTY::Which.which('jack_capture')
  ARECORD = TTY::Which.which('arecord')

  def initialize(selected_port, selected_file, openai_access_token)
    @selected_port = selected_port
    @selected_file = selected_file
    @openai_access_token = openai_access_token
    @cmd = TTY::Command.new(pty: true)
    @reader = TTY::Reader.new(interrupt: :signal)
  end

  # Executes the transcription command
  def execute
    if alsa_device?
      record_audio_with_alsa(480, @selected_port)
    else
      record_audio_with_jack(480, @selected_port)
    end

    # Transcribe audio
    transcription = transcribe_audio(TEMP_FILE_PATH)

    # Print transcription
    puts 'Transcription:'
    puts transcription

    # Write transcription to the selected file
    write_transcription_to_file(transcription, @selected_file)

    Clipboard.copy("#{transcription}")

    `echo #{transcription} | xclip -selection clipboard`

    # # puts "#{clipb}"
    # fork do
    #   exec("xclip -o | xclip -selection clipboard")
    # end

    # Delete temporary WAV file
    delete_temp_file
    exit
  end

  private

  # Checks if the selected port is an ALSA device
  def alsa_device?
    @selected_port.start_with?('sysdefault:')
  end


  # Records audio using arecord
  def record_audio_with_alsa(duration, selected_port)
    stop_recording = false

    recording_pid = Process.spawn("#{ARECORD} -D 'sysdefault:CARD=#{selected_port}' -v -V mono -d #{duration} -f S16_LE -r 48000 #{TEMP_FILE_PATH}")

    input_thread = Thread.new do
      print "Press '8' to stop recording early: "
      puts "\n\n"
      loop do

        user_input = getkeyinput
        puts "Key Pressed: #{user_input.inspect}"

        break if user_input == '8'
      end
      stop_recording = true
      Process.kill('TERM', recording_pid) # Send command to stop recording
    end

    input_thread.join
    Process.wait(recording_pid)

    puts '\n\nRecording stopped early\n' if stop_recording
  end

  # Records audio using jack_capture
  def record_audio_with_jack(duration, selected_port)
    stop_recording = false

    recording_pid = Process.spawn("#{JACK_CAPTURE} -dc -hbu -p '#{selected_port}' -d #{duration} #{TEMP_FILE_PATH}")

    input_thread = Thread.new do
      print "Press '8' to stop recording early: "

      loop do
        x = @reader.read_keypress(nonblock: true)

        if x == "9"
          @copy_to_clipboard = true
          break
        elsif x == "8"
          break
        end

      end

      stop_recording = true
      Process.kill('TERM', recording_pid) # Send command to stop recording
    end

    input_thread.join
    Process.wait(recording_pid)

    puts 'Recording stopped early' if stop_recording
  end

  # Transcribes the audio file
  def transcribe_audio(filename)

    begin
      client = OpenAI::Client.new(access_token: @openai_access_token)

      response = client.transcribe(
        parameters: {
          model: 'whisper-1',
          file: File.open(filename, 'rb')
        }
      )

      if response["error"]
        $logger.fatal("#{response["error"]["message"]}")
        exit
      else
        response['text']
      end

    rescue StandardError => e
      $logger.fatal("something failed #{e}")
    end

  end

  # Writes the transcription to the selected file
  def write_transcription_to_file(transcription, file)
    File.open(file.shellescape, 'a') { |f| f.write("\n#{transcription}\n") }
    $logger.debug("Transcription written to file. #{file}")
    #FIXME: record_audio_with_jack doesn't exit gracefully,
    # so as a work-around we exit here
    exit
  end

  # Deletes the temporary WAV file
  def delete_temp_file
    File.delete(TEMP_FILE_PATH)
  end
end
