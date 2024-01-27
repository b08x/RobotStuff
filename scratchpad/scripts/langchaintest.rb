#!/usr/bin/env ruby
require 'ruby/openai'
require 'logging'
require 'langchain'

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
  config.request_timeout = 60 # Optional
end

# Create a new client
# client = OpenAI::Client.new

openai = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])

prompt = Langchain::Prompt::PromptTemplate.new(template: "Tell me a {adjective} joke.", input_variables: ["adjective"])

x = prompt.format(adjective: "funny") # "Tell me a funny joke."

puts "#{x}"

y = openai.complete(prompt: x)


p y

markdown_table01 = <<~TABLE
| Element               | Function                                    |
|-----------------------|---------------------------------------------|
| Interrogative pronoun | Introduces a question and seeks information  |
| Past tense question   | Forms questions in the past tense            |
| Definite article      | Indicates a specific object                  |
| Noun                  | Represents an aquatic creature               |
| Verb                  | Expresses the action of speaking             |
| Subordinate clause    | Provides additional contextual information  |
| Pronoun               | Refers to the fish                           |
| Verb phrase           | Indicates the action performed by the fish  |
| Preposition           | Introduces a subordinate clause              |
| Definite article      | Specifies the wall that the fish hit         |
| Noun                  | Represents a physical barrier or structure  |
TABLE

markdown_table02 = <<~TABLE
| Element            | Function                                    |
|--------------------|---------------------------------------------|
| Indefinite pronoun | Represents a general or unspecified person   |
| Modal verb         | Indicates possibility or ability             |
| Verb               | Expresses the action of hypothesizing        |
| Determiner         | Indicates an indefinite or non-specific noun |
| Adjective          | Describes the nature of the link             |
| Noun               | Represents a connection or relationship     |
TABLE


prompt_two = Langchain::Prompt::FewShotPromptTemplate.new(
  prefix: "Identify and Map the Cognitive Grammar in the following phrase",
  suffix: "Input: {phrase}\nOutput:",
  example_prompt: Langchain::Prompt::PromptTemplate.new(
    input_variables: ["input", "output"],
    template: "Input: {input}\nOutput: {output}"
  ),
  examples: [
    { "input": "What did the fish say when it hit the wall", "output": markdown_table01 },
    { "input": "one could hypothesize a potential link", "output": markdown_table02 }
  ],
   input_variables: ["phrase"]
)

res = openai.complete(prompt: prompt_two.format(phrase: "illuminate our understanding of synchronicity, offering insights into how this phenomenon has been interpreted and experienced"))

puts "#{res}"

prompt_two.save(file_path: "few_shot_prompt_template.yaml")

prompt_two_yaml = Langchain::Prompt.load_from_path(file_path: "few_shot_prompt_template.yaml")
p prompt_two_yaml.input_variables #=> ["adjective", "content"]
