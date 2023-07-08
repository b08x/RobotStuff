#!/usr/bin/env ruby
# frozen_string_literal: true

require 'logging'
require 'pathname'
require 'pry-stack_explorer'

LOG_DIR = File.join(File.expand_path("../../", __FILE__), "logs")
LOG = File.join(LOG_DIR, "#{Time.now.strftime("%Y-%m-%d")}.log")

LOG_MAX_SIZE = 6_145_728
LOG_MAX_FILES = 10

unless Pathname.new(LOG_DIR).exist?
  Pathname.new(LOG_DIR).mkdir
  puts "creating log directory!"
end

Logging.color_scheme( 'bright',
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

Logging.appenders.stdout(
  'stdout',
  :layout => Logging.layouts.pattern(
    :pattern => '[%d] %-5l %c: %m\n',
    :color_scheme => 'bright'
  ),
  :level => :debug
)

Logging.appenders.file(
  LOG,
  :layout => Logging.layouts.pattern(
    :pattern => '[%d] %-5l %c: %m\n',
    :color_scheme => 'bright'
  ),
  :level => :debug
)

$logger = Logging.logger['Happy::Colors']

$logger.add_appenders(
        Logging.appenders.stdout,
        Logging.appenders.file(LOG))

$logger.debug

def test
  $logger.debug "this is what is happening...all of it"
  $logger.info "basically what is happening"
  $logger.warn "Hey, watch out"
  $logger.error StandardError.new("an error has occurred, continue on to next task")
  $logger.fatal "an error has occured. nothing more can happen."
end

$daemon_options = {
  :log_output => true,
  :backtrace => true,
  :output_logfilename => LOG,
  :log_dir =>  LOG_DIR,
  :ontop => false
}
