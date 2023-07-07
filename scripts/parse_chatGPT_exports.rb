#!/usr/bin/env ruby
require 'json'
require 'fileutils'


def extract_time(timestamp)
  time = Time.at(timestamp)
  time.strftime("%I:%M:%S %p")
end

def write_md_file(title, json_data, i, folder)
  new_md = <<~MD
    
    #{json_data.map { |message| "## #{extract_time(message['create_time'])}-#{message['author']['role']}:\n\n#{message['content']['parts'].join.gsub("\n", "  \n")}\n" }.join("\n\n")}
  MD

  regex = /^##\s(\d{2}):(\d{2}):(\d{2})\s(AM|PM)-assistant:$/

  markdown_output = new_md.gsub(regex, '### \1:\2:\3 \4-assistant:')
  
  File.write(File.join(folder, "#{i}_#{title}.md"), markdown_output)
end


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

# output = File.join(File.dirname(json_file), 'chats', 'v3')

# FileUtils.mkdir output unless Dir.exist?(output)

json_data = File.read(json_file)

# Parse JSON
data = JSON.parse(json_data)


#TODO: 
# Determine chat conversation title. Create a folder using this title
# within the destination} folder. 
#
# Use the title for the file name as well.


destination = File.join(ENV["HOME"], "Workspace", "obsidian", "gpt", "chatGPTexports", "2023_june_21")


# For each conversation in data
data.each_with_index do |item, i|
  begin
    title = item['title'].gsub('.', '')
    
    folder = File.join(destination, "#{i}_#{title}")
    FileUtils.mkdir_p folder unless Dir.exist?(folder)

    messages = item['mapping'].values.reject { |value| value['message']['author']['role'] == 'tool' if value['message'] && value['message']['author'] }.map { |value|
      message = value['message']
      if message && message['content']
        content_parts = message['content']['parts'].map { |part| part.gsub("<", "\\<") }
        message['content']['parts'] = content_parts
        message
      end
    }.compact
    write_md_file(title, messages, i + 1, folder)
  rescue StandardError => e
    puts "#{e.message}"
  end
end
