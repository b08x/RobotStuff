#!/usr/bin/env ruby
# frozen_string_literal: true

# require 'erb'
require "fileutils"
require "yaml"
require "pathname"


unless Dir.exist?(TMPFS)
  FileUtils.mkdir TMPFS
end

module RobotStuff

  class Config

    def self.load_config
      puts "#{APP_ROOT}"
      default_config = File.join(APP_ROOT, "config.default.yml")
      conf_directory = Pathname.new(CONFIG_DIR)

      unless Pathname.new(CONFIG_DIR).exist?
        puts "#{conf_directory}"
        conf_directory.mkdir unless conf_directory.exist?
        puts "#{CONFIG}"
        FileUtils.cp(default_config, CONFIG)
      end

      # YAML.load(ERB.new(File.read(CONFIG_DIR)).result)

      YAML.load_file(CONFIG)

    end

    def self.get(attribute)
      return Config.load_config[attribute]
    end

    def self.set
      File.open(CONFIG, "w") { |file| file.write $CONFIG_DIR.to_yaml }
    end

  end

end

$config = RobotStuff::Config.load_config
$library = RobotStuff::Config.get(:library)

puts "#{$library}"

# soundbot_config_dir = Pathname.new(CONFIG_DIR).to_s

#db_file = File.join(TMPFS, "library.db")
#$library_db = db_file.prepend("sqlite://")
