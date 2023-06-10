#!/usr/bin/env ruby
require 'json'
require 'fileutils'

def write_html_file(title, json_data, i, output)

  new_html = <<~HTML
    <!DOCTYPE html>
    <html>
    <head>
    <title></title>
    </head>
    <body>

    <h1>#{i} #{title}</h1>

    #{json_data.map { |message| "<p><b>#{message['author']['role']}:</b> #{message['content']['parts'].join.gsub("\n", "<br/>")}</p>" }.join}


    </body>
    </html>
  HTML

  File.write(File.join(output, "chat_#{i}.html"), new_html)
end

json_file = ARGV[0]

output = File.join(File.dirname(json_file), 'chats')

FileUtils.mkdir output unless Dir.exist?(output)

json_data = File.read(json_file)

# Parse JSON
data = JSON.parse(json_data)


# For each conversation in data
data.each_with_index do |item, i|
  begin
    title = item['title']
    messages = item['mapping'].values.map { |value| value['message'] }.compact
    write_html_file(title, messages, i + 1, output)
  rescue StandardError => e
    puts "#{e.message}"
  end

end
