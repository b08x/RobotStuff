#!/usr/bin/env ruby
require 'openai'

# Configure OpenAI with your API key
OpenAI.configure do |config|
  config.access_token = ENV['OPENAI_ACCESS_TOKEN']
end

# Create a new client
client = OpenAI::Client.new

# Read the piped input
diff = ARGF.read

# Generate a summary of the diff using OpenAI
response = client.completions(
  parameters: {
    model: "text-davinci-002",
    prompt: "Summarize the following git diff:\n#{diff}\n",
    temperature: 0.3,
    max_tokens: 60
  }
)

# Print the summary
puts response['choices'].first['text'].strip
