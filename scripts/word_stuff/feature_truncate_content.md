To implement the feature of truncating the context of each previous conversation before it is appended to the prompt so that the context window doesn't exceed the token limit, we need to modify the `run` method in the `Completion` class. This method is where the OpenAI model is run with the provided parameters.

Here's a rough idea of what needs to be done:

1. Calculate the number of tokens in the current prompt and the context.
2. If the total number of tokens exceeds the model's maximum limit (for gpt-3.5-turbo, it's 4096 tokens), truncate the context until it fits.
3. Run the model with the updated context and prompt.

Please note that OpenAI's models count tokens, not characters, so we need to ensure that we're counting tokens when we're truncating the context. OpenAI provides a [tiktoken](https://github.com/openai/tiktoken) Python library that can be used to count tokens in a string without making an API call.

However, since this application is written in Ruby, we would need to implement our own token counting or find a Ruby equivalent library. Alternatively, we could create a small Python script that uses tiktoken and call it from our Ruby code.

Once we have a way to count tokens, we can implement the context truncation. Here's a pseudocode of what the updated `run` method might look like:

```ruby
def run(params, research_mode: false, timeout_sec: 60, num_retrials: 1, &block)
  # Get the method for the model
  method = OpenAI.model_to_method(params["model"])

  # Calculate the number of tokens in the prompt and context
  prompt_tokens = count_tokens(params["prompt"])
  context_tokens = count_tokens(params["context"])

  # If the total tokens exceed the limit, truncate the context
  if prompt_tokens + context_tokens > TOKEN_LIMIT
    params["context"] = truncate_context(params["context"], prompt_tokens + context_tokens - TOKEN_LIMIT)
  end

  # Query the OpenAI API
  response = OpenAI.query(@access_token, "post", method, timeout_sec, params, &block)

  # Handle the response...
end
```


The truncate_context function would need to be implemented to truncate the context to a certain number of tokens. This function would take the context, the number of tokens to truncate, and the token counter as arguments. It would then use the token counter to count tokens from the end of the context until it has counted the required number of tokens, and then return the truncated context.

For the truncate_context function, if the calculation of prompt tokens and context tokens exceeds the token limit, save the original context in a json file for future reference, then pass the response then on to the [punkt-segmenter sentence tokenizer](https://github.com/lfcipriani/punkt-segmenter) which will then break down the response into an array of sentences. Then for each sentence, send it to a method to call openAI and ask it to summarize the sentence in half of the words. And then somehow put that back together as the response to then send off to query the OpenAI API.

```ruby
def summarize
  # a method to summaize the lines

tokenizer = Punkt::SentenceTokenizer.new(text)
results    = tokenizer.sentences_from_text(text, :output => :sentences_text)

results.each do |line|
  summarize(line)
end

```


## stopwords
https://github.com/brenes/stopwords-filter
https://www.tm-town.com/natural-language-processing

What is a Stopword?

According to Wikipedia

    In computing, stop words are words which are filtered out prior to, or after, processing of natural language data (text).

And that's it. Words that are removed before you perform some task on the rest of them.


---
```ruby
def normalize(str)
  str.gsub(/[^[:alnum:]]/, ' ').downcase
end
```


https://github.com/yohasebe/engtagger

https://github.com/yohasebe/ruby-spacy#visualizing-dependency

https://github.com/yohasebe/rsyntaxtree


https://github.com/louismullie/treat/wiki/Manual
https://github.com/cjheath/treetop#semantic-predicates
