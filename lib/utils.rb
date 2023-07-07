#!/usr/bin/env ruby
# frozen_string_literal: true

utils_dir = File.expand_path(File.join(__dir__, 'utils'))
$LOAD_PATH.unshift utils_dir unless $LOAD_PATH.include?(utils_dir)

require "command"
require "easyssh"
require "glob"
