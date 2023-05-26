#!/usr/bin/env ruby

require 'tty-command'
require 'tty-logger'
require 'tty-prompt'
require 'optparse'

# Abstract base class for image conversion commands
class ImageConversionCommand
  attr_reader :logger

  def initialize(logger)
    @logger = logger
  end

  def execute(file, output_folder)
    raise NotImplementedError, 'Subclasses must implement this method'
  end

  protected

  def clean_file_name(file_name)
    file_name.strip.gsub(/[^0-9A-Za-z.\-]/, '_')
  end
end

# Command for converting images to ASCII
class AsciiConversionCommand < ImageConversionCommand
  def execute(file, output_folder, options)
    clean_name = clean_file_name(File.basename(file))
    output_file = File.join(output_folder, "#{clean_name}.txt")

    # Prompt the user to select additional options
    prompt = TTY::Prompt.new
    selected_options = prompt.multi_select('Select additional options:', %w[Grayscale Negative Save-Image])
    options[:grayscale] = selected_options.include?('Grayscale')
    options[:negative] = selected_options.include?('Negative')
    options[:save_image] = selected_options.include?('Save-Image')

    # Build the command to convert the image to ASCII
    ascii_command = "ascii-image-converter #{file}"
    if options[:dimensions]
      ascii_command += " -d #{options[:dimensions].join(',')}"
    elsif options[:width] && options[:height]
      ascii_command += " -d #{options[:width]},#{options[:height]}"
    else
      logger.error("Missing dimensions for ASCII conversion. Please provide --dimensions or --width and --height.")
      return
    end

    ascii_command += ' -g' if options[:grayscale]
    ascii_command += ' -n' if options[:negative]

    logger.info("Converting file to ASCII: #{file}")

    # Execute the command with logger as output
    command_result = TTY::Command.new(output: logger).run(ascii_command)

    # Save the ASCII art to the output file
    File.write(output_file, command_result.out)

    logger.success("Converted file to ASCII: #{file}. Saved to: #{output_file}")

    if options[:save_image]
      save_image_path = prompt.ask('Enter path to save the ASCII art as PNG:')
      save_image_path = output_folder if save_image_path.nil? || save_image_path.strip.empty?

      save_image_file = File.join(save_image_path, "#{clean_name}-ascii-art.png")
      save_image_command = "convert #{output_file} #{save_image_file}"

      logger.info("Saving ASCII art as PNG: #{save_image_file}")
      TTY::Command.new(output: logger).run(save_image_command)
      logger.success("ASCII art saved as PNG: #{save_image_file}")
    end
  end
end


# Command for converting images to WebP
class WebpConversionCommand < ImageConversionCommand
  def execute(file, output_folder, options)
    clean_name = clean_file_name(File.basename(file))
    output_file = File.join(output_folder, "#{clean_name}.webp")

    # Build the command to convert the image to WebP
    webp_command = "cwebp #{file} -q 80 -resize #{options[:width]} #{options[:height]} #{output_file}"
    logger.info("Converting file to WebP: #{file}")

    # Execute the command with logger as output
    TTY::Command.new(output: logger).run(webp_command)

    logger.success("Converted file to WebP: #{file}. Saved to: #{output_file}")
  end
end

# Command for converting images to PNG
class PngConversionCommand < ImageConversionCommand
  def execute(file, output_folder, options)
    clean_name = clean_file_name(File.basename(file))
    output_file = File.join(output_folder, "#{clean_name}.png")

    # Build the command to convert the image to PNG
    png_command = "convert #{file} -resize #{options[:width]}x#{options[:height]}\\> #{output_file}"
    logger.info("Converting file to PNG: #{file}")

    # Execute the command with logger as output
    TTY::Command.new(output: logger).run(png_command)

    logger.success("Converted file to PNG: #{file}. Saved to: #{output_file}")
  end
end

# Parse the command-line options
options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: image_converter.rb [options] folder_path'

  opts.on('-f', '--format FORMAT', [:ascii, :webp, :png], 'Output format (ascii, webp, png)') do |format|
    options[:format] = format
  end

  opts.on('-W', '--width WIDTH', Integer, 'Output image width') do |width|
    options[:width] = width
  end

  opts.on('-H', '--height HEIGHT', Integer, 'Output image height') do |height|
    options[:height] = height
  end
end.parse!

# Initialize TTY Logger
logger = TTY::Logger.new(output: STDOUT)

# Create the appropriate image conversion command based on the selected format
case options[:format]
when :ascii
  conversion_command = AsciiConversionCommand.new(logger)
when :webp
  conversion_command = WebpConversionCommand.new(logger)
when :png
  conversion_command = PngConversionCommand.new(logger)
else
  prompt = TTY::Prompt.new
  selected_format = prompt.select('Select output format:', %w[ASCII WebP PNG])
  options[:format] = selected_format.downcase.to_sym
  conversion_command = case selected_format
                       when 'ASCII'
                         AsciiConversionCommand.new(logger)
                       when 'WebP'
                         WebpConversionCommand.new(logger)
                       when 'PNG'
                         PngConversionCommand.new(logger)
                       end
end

folder_path = ARGV.first
output_folder = "#{File.expand_path(folder_path)}/converted"
Dir.mkdir(output_folder) unless Dir.exist?(output_folder)

# If dimensions were not specified, prompt the user to input them
if options[:width].nil? || options[:height].nil?
  prompt = TTY::Prompt.new
  options[:width] = prompt.ask('Enter output image width:') do |q|
    q.convert :int
  end
  options[:height] = prompt.ask('Enter output image height:') do |q|
    q.convert :int
  end
end

# Execute the conversion command for each image in the folder
Dir.glob("#{folder_path}/*.{png,img}") do |file|
  begin
    conversion_command.execute(file, output_folder, options)
  rescue StandardError => e
    logger.error("Error converting file: #{file}")
    logger.error(e.message)
    logger.error(e.backtrace.join("\n"))
  end
end
