# robotstuff

ruby tools for NLP related tasks

<https://pt.slideshare.net/diasks2/exploring-natural-language-processing-in-ruby>
<https://pt.slideshare.net/TomCartwright/natual-language-processing-in-ruby>

<https://github.com/yohasebe/lemmatizer>
<https://github.com/yohasebe/ruby-spacy>

<https://github.com/diasks2/pragmatic_tokenizer>

<https://github.com/BattleBrisket/finishing_moves>

Today we will be starting on a Ruby application that performs various NLP related tasks.
The application name will be called "RobotStuff"

A high-level overview of the features:

Sentiment analysis: Transforms large amounts of customer feedback, reviews, or social media reactions into actionable results.
Machine translation: Translates large amounts of text from a target to a source language.
Named-entity recognition: Extracts entities from text, such as people, locations, organizations, and dates.
Automatic summarization: Creates summaries and synopses for indexes, research databases, or busy readers.
Topic model: Identifies a text's topic using unsupervised machine learning.
Parsing: Verifies the correct syntax of a group of words and creates a structural input representation.
Document classification: Assigns tags to texts to put them in categories.
Stemming: Reduces words to their word stem.
Lemmatization: Reduces words to their root word.
Visual Mapping: Produce graphs of phrases and sentences to show correlations

A table of gems that will be used in this application:

| gem                                                                       | description                                                                                          | NLP Technique               |
| :------------------------------------------------------------------------ | :--------------------------------------------------------------------------------------------------- | --------------------------- |
| [engtagger](https://github.com/yohasebe/engtagger)                        | a probability based, corpus-trained tagger that assigns POS tags to English text                     | Part-of-Speech Tagging      |
| [finishing_moves](https://github.com/battlebrisket/finishing_moves)       | small, focused, incredibly useful methods                                                            | -                           |
| [fuzzy_tools](https://github.com/brianhempel/fuzzy_tools)                 | easy, high quality fuzzy search                                                                      | Fuzzy Search                |
| [lemmatizer](https://github.com/yohasebe/lemmatizer)                      | Lemmatizer for text in English.                                                                      | Lemmatization               |
| [jsonl](https://github.com/zenizh/jsonl)                                  | convert to jsonl                                                                                     | -                           |
| [parallel](https://github.com/grosser/parallel)                           | Run any kind of code in parallel processes                                                           | -                           |
| [pragmatic_tokenizer](https://github.com/diasks2/pragmatic_tokenizer)     | A multilingual tokenizer to split a string into tokens.                                              | Tokenization                |
| [rsyntaxtree](http://github.com/yohasebe/rsyntaxtree)                     | syntaxtree generator                                                                                 | Syntax Parsing              |
| [ruby-openai](https://github.com/alexrudall/ruby-openai)                  | OpenAI API                                                                                           |                             |
| [ruby-spacy](https://github.com/yohasebe/ruby-spacy)                      | This module aims to make it easy and natural for Ruby programmers to use spaCy.                      | Natural Language Processing |
| [sequel](https://sequel.jeremyevans.net/)                                 | database toolkit                                                                                     | -                           |
| [terminal-table](https://github.com/tj/terminal-table)                    | Simple, feature rich ascii table generation library                                                  | -                           |
| [treetop](https://github.com/cjheath/treetop)                             | A Ruby-based parsing DSL based on parsing expression grammars.                                       | Parsing                     |
| [tty-box](https://github.com/piotrmurach/tty-box)                         | Draw various frames and boxes in the terminal window.                                                | -                           |
| [tty-command](https://github.com/piotrmurach/tty-command)                 | Execute shell commands with pretty output logging and capture their stdout, stderr and exit status.  | -                           |
| [tty-progressbar](https://github.com/piotrmurach/tty-progressbar)         | Display a single or multiple progress bars in the terminal.                                          | -                           |
| [tty-prompt](https://github.com/piotrmurach/tty-prompt)                   | interactive command line prompt with a robust API for getting and validating complex inputs.         | -                           |
| [tty-screen](https://github.com/piotrmurach/tty-screen)                   | Terminal screen size detection                                                                       | -                           |
| [chroma](https://github.com/mariochavez/chroma)                           | This Ruby gem is a client to connect to Chroma's database via its API.                                             | Vector Search               |
| [wordnet](https://hg.sr.ht/~ged/ruby-wordnet)                             | This library is a Ruby interface to WordNet®.                                                        | WordNet Interface           |
| [stopwords-filter](https://github.com/brenes/stopwords-filter)            | implementation of a stopwords filter that remove a list of banned words (stopwords) from a sentence. | Stopword Removal            |

Use the Pipes-and-Filters design pattern. Pipes-and-Filters describes how
systems process data streams.

In this pattern, data enters the system from multiple sources and passes through sequential filters that transform the data from one format to another.

For the Segmenting, use pragmatic_tokenizer, using the [golden_rules](https://s3.amazonaws.com/tm-town-nlp-resources/golden_rules.txt)

Let's think through this step by step.

##### vector db

<https://github.com/weaviate/weaviate/blob/master/docker-compose.yml>
<https://github.com/andreibondarev/weaviate-ruby>

<https://github.com/openai/openai-cookbook/tree/main/examples/vector_databases/weaviate>

<https://hub.docker.com/r/redis/redis-stack>
redis and ohm ?

##### possible addons

<https://github.com/openai/openai-cookbook/blob/main/examples/Code_search.ipynb>

<https://github.com/louismullie/treat/wiki/Quick-Tour>
<https://github.com/louismullie/treat/wiki/Manual>
