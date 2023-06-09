#!/usr/bin/env ruby
require 'nokogiri'
require 'json'
require 'fileutils'

def write_html_file(json_data, i)
  new_html = <<~HTML
    <!DOCTYPE html>
    <html>
    <head>
    <title>Page Title</title>
    </head>
    <body>

    <h1>Chat #{i}</h1>

    #{json_data.map { |message| "<p>#{message['content']['parts'].join}</p>" }.join}

    </body>
    </html>
  HTML

  File.write("chat_#{i}.html", new_html)
end

filename = ARGV[0]
# Read HTML from file
html_content = File.read(filename)

# Parse the HTML
doc = Nokogiri::HTML(html_content)


# Regex to find script tag and extract JSON data
script = doc.css('script')


json_data = script[/var jsonData = (\[.*\]);/, 1]
p json_data

# Ensure json_data is not nil
if json_data.nil?
  puts "Could not find JSON data in the HTML file"
  exit
end

# Remove HTML escaped characters
json_data.gsub!('&#x27;', "'")

# Parse JSON
data = JSON.parse(json_data)

# For each conversation in data
data.each_with_index do |item, i|
  messages = item['mapping'].values.map { |value| value['message'] }.compact
  write_html_file(messages, i + 1)
end
