#!/usr/bin/env ruby
require 'ruby/openai'
require 'logging'

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
  config.access_token = ENV['OPENAI_ACCESS_TOKEN']
end

# Create a new client
client = OpenAI::Client.new

# Read the piped input
diff = ARGF.read

# Best practices for commit messages
best_practices = """
1. Separate subject from body with a blank line.
2. Limit the subject line to 50 characters.
3. Do not end the subject line with a period.
4. Use the imperative mood in the subject line.
5. Wrap the body at 72 characters.
6. Use the body to explain what and why vs. how.
"""

# Generate a summary of the diff using OpenAI
response = client.chat(
  parameters: {
    model: "gpt-3.5-turbo",
    messages: [
      {role: "system", content: best_practices},
      {role: "user", content: "Summarize the following git diff:\n#{diff}\n"}
    ],
    temperature: 0.5,
    max_tokens: 1024
    # frequency_penalty: 0.2,
    # presence_penalty: 0.5
  }
)

$logger.debug(response)

# Get the summary and escape it for use in a shell command
summary = response['choices'][0]['message']['content'].strip

puts "#{summary}"
