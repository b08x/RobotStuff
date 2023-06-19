#!/usr/bin/env ruby
require 'ruby/openai'
require 'rugged'

class Repository
  attr_accessor :state

  def initialize(path)
    @path = path
    @repo = Rugged::Repository.new(path)
    @state = determine_state
  end

  def diff
    `cd #{@path} && git diff`
  end

  def add_commit(commit_message)
    `cd #{@path} && git add . && git commit -m "#{commit_message}"`
  end

  def push
    `cd #{@path} && git push`
  end

  def handle
    @state.handle
  end

  private

  def determine_state
    diff.empty? ? CleanState.new(self) : DirtyState.new(self)
  end
end

class State
  def initialize(repo)
    @repo = repo
  end

  def handle
    raise NotImplementedError, 'This method must be overridden in a subclass'
  end
end

class CleanState < State
  def handle
    # Nothing to do
  end
end

class DirtyState < State
  def handle
    diff = @repo.diff
    if diff != ""
      commit_message = CommitMessageGenerator.new(diff).generate
      puts "Generated commit message: #{commit_message}"
      print "Do you approve this commit message? (y/n): "
      response = gets.chomp
      if response.downcase == 'y'
        @repo.add_commit(commit_message)
        print "Do you want to push it? (y/n): "
        if response.downcase == 'y'
          @repo.push
          puts "Pushed it real good"
        else
          puts "I guess you didn't want to push it real good. That's fine."
          @repo.state = CleanState.new(@repo)
        end
      else
        puts "Commit cancelled."
      end
    end
  end
end


class CommitMessageGenerator
  def initialize(diff)
    @diff = diff
  end

  def generate
    OpenAI.configure do |config|
      config.access_token = ENV.fetch("OPENAI_ACCESS_TOKEN")
    end
    client = OpenAI::Client.new

    response = client.chat(
      parameters: {
          model: "gpt-3.5-turbo", # Required.
          messages: [{ role: "assistant", content: "Please summarize the following changes:\n#{@diff}"}], # Required.
          temperature: 0.7,
      })

      p response

      response.dig("choices", 0, "message", "content")
  end
end

puts "hey"

# Usage
repo = Repository.new(File.join(ENV['HOME'], 'Workspace', 'syncopated', 'iso'))
p repo
repo.handle

# set an alias
#alias gpush="mirrorgit.rb $PWD"
