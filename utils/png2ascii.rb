#!/usr/bin/env ruby

require 'tty-command'
require 'tty-logger'
require 'optparse'
require 'shellwords'

# Check if ascii-image-converter is installed
unless system('command -v ascii-image-converter > /dev/null 2>&1')
  puts 'ascii-image-converter is not installed. Please install it first.'
  exit 1
end

# Check if cwebp is installed
unless system('command -v cwebp > /dev/null 2>&1')
  puts 'cwebp is not installed. Please install it first.'
  exit 1
end

# Parse command line options
options = {}
OptionParser.new do |opts|
  opts.on('-d', '--dimensions WIDTH,HEIGHT', Array, 'Set width and height for ascii art in CHARACTER length') do |dimensions|
    options[:dimensions] = dimensions
  end
  opts.on('-W', '--width WIDTH', Integer, 'Set width for ascii art in CHARACTER length') do |width|
    options[:width] = width
  end
  opts.on('-H', '--height HEIGHT', Integer, 'Set height for ascii art in CHARACTER length') do |height|
    options[:height] = height
  end
  opts.on('-f', '--full', 'Use largest dimensions for ascii art') do
    options[:full] = true
  end
  opts.on('-C', '--color', 'Display ascii art with original colors') do
    options[:color] = true
  end
  opts.on('--color-bg', 'If color flag is passed, use that color on character background instead of foreground') do
    options[:color_bg] = true
  end
  opts.on('-g', '--grayscale', 'Display grayscale ascii art') do
    options[:grayscale] = true
  end
  opts.on('-h', '--help', 'Display this help message') do
    puts opts
    exit
  end
end.parse!

# Check if folder is provided
if ARGV.empty?
  puts 'Please provide the folder path.'
  puts 'Usage: ./convert_to_ascii.rb folder_path [options]'
  exit 1
end

folder_path = ARGV[0]

# Check if folder exists
unless Dir.exist?(folder_path)
  puts "Folder '#{folder_path}' does not exist."
  exit 1
end

# Configure logger
logger = TTY::Logger.new(output: STDOUT)

# Create a new folder for storing the converted files
output_folder = File.join(folder_path, 'ascii_output')
FileUtils.mkdir_p(output_folder)

# Helper method to clean file name
def clean_file_name(file_name)
  file_name.strip.gsub(/[^0-9A-Za-z.\-]/, '_')
end

# glob for png and jpg
files = Dir.glob("#{folder_path}/*.{png,jpg}")

# Convert all PNG and JPG files to ASCII within the folder
files.each do |file|

  # Clean file name
  clean_name = clean_file_name(File.basename(file))

  # Determine the output file path for the WebP conversion
  webp_file = File.join(output_folder, "#{clean_name}.webp")

  # Convert the image to WebP format with dimensions no greater than 2560x1440
  cwebp_command = "cwebp -q 80 -resize 2560 1440 #{file.shellescape} -o #{webp_file}"
  TTY::Command.new(output: logger).run(cwebp_command)

  # Log the WebP conversion success
  logger.success("Converted to WebP: #{file}. Saved to: #{webp_file}")

  # Build the command
  command = "ascii-image-converter "

  # Add options for dimensions, color, and grayscale
  command += " -d #{options[:dimensions].join(',')}" if options[:dimensions]
  command += " -W #{options[:width]}" if options[:width]
  command += " -H #{options[:height]}" if options[:height]
  command += " -C -c" if options[:color]
  command += " --color-bg" if options[:color_bg]
  command += " -g" if options[:grayscale]
  command += " -f" if options[:full]

  command += " #{webp_file} -s #{output_folder}"

  # Execute the command with logger as output
  command_result = TTY::Command.new(output: logger).run(command)

  # Print the ASCII image
  puts "File: #{file}"
  puts "Output Folder: #{output_folder}"
  logger.info("converted #{file}")
  puts
end
