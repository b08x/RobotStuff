#!/usr/bin/env ruby

# Class responsible for selecting the input device
class InputDevice
  def initialize(config)
    @config = config
    @prompt = TTY::Prompt.new
  end

  # Selects the input device based on user preference or default configuration
  def select_input_device
    input_source = @config.fetch(:input_source) { @prompt.select("Select the input source:", %w[alsa jack]) }
    @config.set(:input_source, value: input_source)
    @config.write(force: true)

    case input_source
    when 'alsa'
      select_alsa_device
    when 'jack'
      select_jack_port
    else
      puts "Invalid input source. Exiting..."
      exit
    end
  end

  private

  # # Selects the input device in the alsa input source
  # def select_alsa_device
  #   device_list = `arecord -l`
  #   devices = device_list.scan(/card \d+: .*?\n/)
  #
  #   selected_device = @config.fetch(:alsa_device) { @prompt.select("Select the input device:", devices) }.strip
  #   @config.set(:alsa_device, value: selected_device)
  #   @config.write(force: true)
  #
  #   card_number = selected_device.match(/card (\d+):/)[1]
  #   device_number = selected_device.match(/device (\d+):/)[1]
  #   "hw:#{card_number},#{device_number}"
  # end

  # Selects the input device in the alsa input source
  def select_alsa_device
    device_list = `arecord -L`
    devices = device_list.scan(/sysdefault:CARD=(.*?)\n/).flatten

    selected_device = @config.fetch(:alsa_device, nil)
    if selected_device.nil?
      selected_device = @prompt.select("Select the input device:", devices).strip
      @config.data['alsa_device'] = "sysdefault:CARD=#{selected_device}"
      @config.write(force: true)
    end

    selected_device_match = selected_device.match(/sysdefault:CARD=(.*)/)
    if selected_device_match
      selected_device_match[1]
    else
      raise "Failed to extract ALSA device name"
    end
  end

  # Selects the capture port in the jack input source
  def select_jack_port
    if TTY::Which.exist?('jack_lsp')
      port_list = `jack_lsp`
      ports = port_list.split("\n").select { |port| port.include?('capture') }

      selected_port = @config.fetch(:jack_port) { @prompt.select("Select the capture port:", ports) }
      @config.set(:jack_port, value: selected_port)
      @config.write(force: true)

      selected_port
    else
      puts 'jack_lsp does not appear to be installed. Exiting...'
      exit
    end
  end
end
