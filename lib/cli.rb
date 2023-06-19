#!/usr/bin/env ruby
# frozen_string_literal: false

require 'daemons'
require "drydock"
require "highline/import"

module RobotStuff
  class CLI
    extend Drydock

    default :welcome
    debug :on

    before do
      @hostname = `cat /etc/hostname`.strip
    end

    about "about"
    command :about do |_obj|
      puts "hey...this is what this is about!"
    end

    about "main menu"
    command :menu do |_obj|
      RobotStuff::Menu.start
    end



  end # end cli class
end # end soundbot module
