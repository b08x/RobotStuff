#!/usr/bin/env ruby
# frozen_string_literal: true
require 'ruport'
require 'yaml'

def show(folder)
  p folder
  begin
    if Dir.glob(File.join(folder, "**/vars/*")).count == 0
      puts 'Not Found'
      exit 1
    end
    table = Ruport::Data::Table.new
    table.column_names = %w[File Key Value]

    regexp_str = Array.new
    regexp_str << "**/vars/*" # search roles/*/vars/*.yml
    p regexp_str

    regexp_str.first {|str|
      p str
      Dir.glob(str) {|f|
        next unless FileTest.file?(f) #skip directory
        yml = YAML.load_file(f)
        p yml
        p str
        if yml == false
          puts "No Variables in #{f}"
          next
        end
        if str == "**/vars/*"
          yml.each{|h|
            if h.instance_of?(Hash) && h.has_key?("vars")
              h["vars"].each{|key,value|
                table << [f,key,value]
              }
            end
          }
        else
          yml.each{|key,value|
            table << [f,key,value]
          }
        end
      }
    }

    if table.count > 0
      puts table.to_text
    end
  rescue => e
    puts e
    fail 'Sorry. Error hanppend..'
  end
end

f = File.join(ENV['HOME'], "Workspace", "syncopated", "playbooks")
show(f)
