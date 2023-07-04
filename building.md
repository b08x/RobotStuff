# requirements


Generate a ruby script with the following requirements:

1. scans an directory, which are folders that contain txt files in wiki format
   Pages in Zim are stored as text files in normal folders and subfolders in your file system. The file name is used as the page name. The hierarchical structure is similar to the one appearing in the index. The file names should contain no blanks. Convert these to JSONL format.

   for each file:
		* clean up file, remove wiki header which looks like this:
		   ```text
		   Content-Type: text/x-zim-wiki
			Wiki-Format: zim 0.6
			Creation-Date: 2023-05-15T11:42:47-04:00
			```
    * discard: [tags, spans, heading format, table, tr, td, th, caption, div, form, input, selection, ul, li, ol, dl, dt, dd, ref, sub, sup]

    * remove grammatically extraneous characters

    * Use [pragmatic_tokenizer gem](https://raw.githubusercontent.com/diasks2/pragmatic_tokenizer/master/README.md) to cleanup tokens
      - expand_contractions, hashtags, mentions, clean all set to true
      - use https://github.com/yohasebe/engtagger to tag parts of speech in tokenized sentences.

    * use openai to generate a summary of each page/file

    * store file content in a database
			1. use file name as primary key
			2. category can be the parent folder name if it is captialized
			3. create summary and fulltext tables to store the summary and complete text
      * use sequel gem
        **Page Table**: This table will store information about each page in the zim wiki knowledgebase.
         - `page_id` (Primary Key): Unique identifier for each page.
         - `title`: Title of the page.
         - `content`: Content of the page in JSONL format.
         - `summary`: Automatically generated summary for the page.

      For the summary, take into account the grammatical structure and semantic context of the surrounding words. max length 100 words. nothing specific should be emphasized.

      eventually, we'll want to use this database for embedding an LLM

Follow this design pattern:

1. Singleton Pattern: Use a singleton class to handle the scanning of the directory and processing of the files. This ensures that only one instance of the class is created and used throughout the application.

2. Factory Pattern: Use a factory class to create instances of the classes that handle the cleaning of the file, the generation of the summary, and the storage of the file content in the database. This allows for easy creation and management of these objects.

3. Strategy Pattern: Use the strategy pattern to handle the tagging of parts of speech in tokenized sentences and the creation of visual diagrams of sentences. This allows for easy swapping of different algorithms or libraries for these tasks.

4. Observer Pattern: Use the observer pattern to notify the user or other parts of the application when a file has been processed and stored in the database. This allows for easy integration with other parts of the application that may need to use the stored data.





5. a. [named-entity](https://github.com/yohasebe/ruby-spacy#named-entity-recognition) b. [part of speech](https://github.com/yohasebe/ruby-spacy#part-of-speech-and-dependency) c. [morphology](https://github.com/yohasebe/ruby-spacy#morphology)
