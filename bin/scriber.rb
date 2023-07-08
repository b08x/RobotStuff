#!/usr/bin/env ruby

lib_dir = File.expand_path(File.join(__dir__, '..', 'lib'))
$LOAD_PATH.unshift lib_dir unless $LOAD_PATH.include?(lib_dir)

require 'openai'
require 'securerandom'
require 'tty-config'
require 'tty-which'
require 'tty-prompt'

require 'logger'
require 'audio_input'
require 'file_select'
require 'transcribe'
require 'i3_nav'


NOTEBOOK = File.join(Dir.home, "Notebook")

# Method that initiates the transcription process
def main
  config = TTY::Config.new
  config.append_path APP_ROOT
  config.read if config.exist?

  # Select the input device
  input_device = InputDevice.new(config)
  selected_port = input_device.select_input_device

  #TODO: menu to select a file
  #prompt = TTY::Prompt.new
  #new_file = prompt.ask("Select a new file?", convert: :boolean)

  # Prompt for the markdown file to paste the transcription
  markdown_file = MarkdownFile.new(config)
  selected_file = if ARGV[0] == '--new-file'
                    markdown_file.select_markdown_file
                  else
                    config.fetch(:selected_file) { markdown_file.select_markdown_file }
                  end

  $logger.debug("#{selected_file}")

  # Fetch the openai_access_token from the config file
  openai_access_token = config.fetch(:openai_access_token)

  # Execute the transcription command
  command = TranscribeCommand.new(
                                  selected_port,
                                  selected_file,
                                  openai_access_token
                                  )
  command.execute
end

main
