#!/usr/bin/env ruby
# frozen_string_literal: true

lib_dir = File.expand_path(File.join(__dir__, '..', 'lib'))
$LOAD_PATH.unshift lib_dir unless $LOAD_PATH.include?(lib_dir)

CONFIG_DIR = File.join(ENV['HOME'], '.config', 'robotstuff')
CONFIG = File.join(CONFIG_DIR, "config.yml")

TMPFS = File.join("/tmp/robotstuff")

def progname; "robotstuff"; end

module RobotStuff
  VERSION = "0.9.8"
end

require "logor"
require "config"
require "utils"

require "cli"

if ARGV.any?
  Drydock.run!(ARGV, $stdin) if Drydock.run? && !Drydock.has_run?
end
