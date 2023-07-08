#!/usr/bin/env ruby
# frozen_string_literal: true

require 'tty-config'
require 'ruby/openai'

APP_ROOT = File.expand_path("../../", __FILE__)

lib_dir = File.expand_path(File.join(__dir__, '..', 'lib'))
$LOAD_PATH.unshift lib_dir unless $LOAD_PATH.include?(lib_dir)

$config = TTY::Config.new
$config.append_path(APP_ROOT)
$config.read

require "loger"
require "cli"

module GPT
  module_function

  def client
    OpenAI.configure do |openai|
      openai.access_token = ENV['OPENAI_API_KEY']
      openai.request_timeout = 60 # Optional
    end

    gptClient = OpenAI::Client.new
    return gptClient
  end

end

if ARGV.any?
  Drydock.run!(ARGV, $stdin) if Drydock.run? && !Drydock.has_run?
end
