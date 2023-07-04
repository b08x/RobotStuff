#!/usr/bin/env ruby
require 'ruby/openai'
require 'tiktoken_ruby'
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

module TikToken
  extend self

  DEFAULT_MODEL = "gpt-3.5-turbo"

  def count(string, model: DEFAULT_MODEL)
    get_tokens(string, model: model).length
  end

  def get_tokens(string, model: DEFAULT_MODEL)
    encoding = Tiktoken.encoding_for_model(model)
    tokens = encoding.encode(string)
    tokens.map do |token|
      [token, encoding.decode([token])]
    end.to_h
  end
end


# Configure OpenAI with your API key
OpenAI.configure do |config|
  config.access_token = ENV['OPENAI_ACCESS_TOKEN']
end

# Create a new client
client = OpenAI::Client.new


# def get_meronyms(word):
#
# def get_holonyms(word):
#
#
# def tokenizer
#
# def stopwords_filter
#
# Stanza lemmatizer
# https://medium.com/@yashj302/lemmatization-f134b3089429


system_prompt = """
Process this {{ sentence|phrase|paragraph }} and correlate the cognitive grammar to Wordnet senses and Functional Grammar

Then Correlate Word, Part of Speech, Wordnet senses, Cognitive grammar, Functional grammar with Pragmatics

Then Correlate Word, Part of Speech, Wordnet senses, Cognitive grammar, Functional grammar, Pragmatics with Generative grammar

Output in mermaid syntax format.
"""


messages = [
    {"role": "system", "content": "You are an AI language model trained to analyze and summarize product reviews."},
    {"role": "user", "content": f"Summarize the following product review, highlighting pros and cons: {review}"}
]

## example function call

def get_current_weather(location:, unit: "fahrenheit")
  # use a weather api to fetch weather
end

response =
  client.chat(
    parameters: {
      model: "gpt-3.5-turbo-0613",
      messages: [
        {
          "role": "user",
          "content": "What is the weather like in San Francisco?",
        },
      ],
      functions: [
        {
          name: "get_current_weather",
          description: "Get the current weather in a given location",
          parameters: {
            type: :object,
            properties: {
              location: {
                type: :string,
                description: "The city and state, e.g. San Francisco, CA",
              },
              unit: {
                type: "string",
                enum: %w[celsius fahrenheit],
              },
            },
            required: ["location"],
          },
        },
      ],
    },
  )

message = response.dig("choices", 0, "message")

if message["role"] == "assistant" && message["function_call"]
  function_name = message.dig("function_call", "name")
  args =
    JSON.parse(
      message.dig("function_call", "arguments"),
      { symbolize_names: true },
    )

  case function_name
  when "get_current_weather"
    get_current_weather(**args)
  end
end
