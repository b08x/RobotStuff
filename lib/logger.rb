#!/usr/bin/env ruby

require 'logging'
require 'pathname'

APP_ROOT = File.expand_path("../../", __FILE__)

LOG_DIR = File.join(File.expand_path("../../", __FILE__), "logs")
LOG_MAX_SIZE = 6_145_728
LOG_MAX_FILES = 10

def progname; "scriber"; end

log_file = File.join(LOG_DIR, "#{progname}-#{Time.now.strftime("%Y-%m-%d")}.log")

$osc_log = File.join("#{progname}-#{Time.now.strftime("%Y-%m-%d")}_osc.log")

unless Pathname.new(LOG_DIR).exist?
  Pathname.new(LOG_DIR).mkdir
  puts "Creating log directory!"
end

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

file_appender = Logging.appenders.file(
  log_file,
  :layout => Logging.layouts.pattern(
    :pattern => '[%d] %-5l %c: %m\n',
    :color_scheme => 'bright'
  ),
  :level => :debug,
  :truncate => true,
  :size => LOG_MAX_SIZE,
  :keep => LOG_MAX_FILES
)

# Create a logger with appenders
$logger = Logging.logger['Happy::Colors']
$logger.add_appenders(stdout_appender, file_appender)

# Set the log level
$logger.level = :debug

# Log some test messages
def test
  $logger.debug("This is what is happening...all of it")
  $logger.info("Basically what is happening")
  $logger.warn("Hey, watch out")
  $logger.error(StandardError.new("An error has occurred, continue on to the next task"))
  $logger.fatal("An error has occurred. Nothing more can happen.")
end

$daemon_options = {
  :log_output => true,
  :backtrace => true,
  :output_logfilename => $osc_log,
  :log_dir => LOG_DIR,
  :ontop => false
}

