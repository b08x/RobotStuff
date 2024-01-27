#!/usr/bin/env ruby
require 'ruby/openai'
require 'logging'
require 'clipboard'

# Set up logging configuration
Logging.color_scheme('bright',
  :levels => {
    :info  => :green,
    :warn  => :yellow,
    :error => :red,
    :fatal => [:white, :on_red]
  },
  :date => :blue,
  :logger => :cyan,
  :message => :magenta
)

# Configure appenders
stdout_appender = Logging.appenders.stdout(
  'stdout',
  :layout => Logging.layouts.pattern(
    :pattern => '[%d] %-5l %c: %m\n',
    :color_scheme => 'bright'
  ),
  :level => :debug
)

# Create a logger with appenders
$logger = Logging.logger['gdiffsum']
$logger.add_appenders(stdout_appender)

# Set the log level
$logger.level = :debug

# Configure OpenAI with your API key
OpenAI.configure do |config|
  config.access_token = ENV['OPENAI_API_KEY']
  config.request_timeout = 60 # Optional
end

# Create a new client
client = OpenAI::Client.new

# Read the piped input
diff = ARGF.read

# Best practices for commit messages
best_practices = """
Analyze the git diff and summarize the changes for a git commit message.
Use past tense.
Do not end a line with a period.
Separate subject from body with a blank line.
Limit the subject line to 50 characters.
Use the imperative mood in the subject line.
Try to ascertain why each change as made.
Wrap the body at 72 characters.
"""

STREAMING_TIMEOUT = -0.1150

def time_check(elapsed_time)
  #p elapsed_time
  if elapsed_time < STREAMING_TIMEOUT
    error_message = "Error: No new response received within 5 seconds after the last response has been processed."
    res = { "type" => "error", "content" => "ERROR: #{error_message}" }
    #pp res
    $logger.debug(res)
    sleep 1
    return res
  end
end


puts "-----------------"

# Initialize the JSON variable and the last processed time.
json = nil
end_time = Time.now

begin
  # Generate a summary of the diff using OpenAI
  response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo-16k-0613",
      messages: [
        {role: "system", content: best_practices},
        {role: "user", content: "###\n#{diff}\n###"}
      ],
      temperature: 0.8,
      top_p: 0.5,
      max_tokens: 2000,
      frequency_penalty: -0.3,
      presence_penalty: 0.4,
      stream: proc do |chunk, _bytesize|
        # $logger.debug(chunk)
        current_time = Time.now
        content = chunk.dig("choices", 0, "delta", "content")
        #p content
        print content.gsub("`", "'") unless content.nil?
        sleep 0.1125
        end_time = Time.now
        elapsed_time = (current_time - end_time).to_f
        time_check(elapsed_time)
      end
    }
  )
  # $logger.debug(response)
  #
  # # Get the summary and escape it for use in a shell command
  # summary = response['choices'][0]['message']['content'].strip
  #
  # puts "#{summary}"
rescue StandardError => e
  $logger.fatal("#{e}")
end
