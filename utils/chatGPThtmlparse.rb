#!/usr/bin/env ruby
require 'json'
require 'nokogiri'
require 'erb'

def create_html(title, messages, outputFolder)
  template = ERB.new <<-HTML
  <!DOCTYPE html>
  <html>
  <head>
      <title><%= title %></title>
  </head>
  <body>
      <h1><%= title %></h1>
      <% messages.each do |message| %>
        <p><%= message %></p>
      <% end %>
  </body>
  </html>
  HTML

  File.write("#{outputFolder}/#{title.gsub(/[^0-9A-Za-z]/, '_')}.html", template.result(binding))
end

filename = ARGV[0]
outputFolder = "/home/b08x/Workspace/chatGPTexports/2023_june/output"

html = File.read(filename)
doc = Nokogiri::HTML(html)

# Regex to find script tag and extract JSON data
script = doc.css('body script').text
json_data = script[/var jsonData = (.*);/, 1]

begin
  # Fix escape characters
  json_data.gsub!('\\"', '"')
  json_data.gsub!("\\'", "'")
rescue
  puts "placeholder"
end
# Parse JSON data into Ruby hash
data = JSON.parse(json_data)

# Create individual HTML files from data
data.each do |conversation|
  title = conversation['title']
  messages = conversation['mapping'].values.map { |message| message['message']['content']['parts'][0] if message['message'] }.compact
  create_html(title, messages, outputFolder)
end
