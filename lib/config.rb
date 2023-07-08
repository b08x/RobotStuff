#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "pathname"
require "yaml"

module RobotStuff

  class Config

    def self.load_config

      default_config = File.join(APP_ROOT, "config.default.yml")
      conf_directory = Pathname.new(CONFIG_DIR)

      unless Pathname.new(CONFIG_DIR).exist?
        conf_directory.mkdir unless conf_directory.exist?
        FileUtils.cp(default_config, CONFIG)
      end

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
