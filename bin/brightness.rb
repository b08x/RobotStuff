#!/usr/bin/env ruby
# frozen_string_literal: true

# a tui driven menu for:
# https://github.com/philippnormann/xrandr-brightness-script

require 'tty-prompt'

module Brightness
  module_function

  def prompt
    prompt = TTY::Prompt.new(interrupt: :exit)
    return prompt
  end
  #TODO: ensure $PATH can be read, so this can just be set to a file name
  # as when the path changes, this will cease to function.
  def set(monitor,level)
    `/usr/local/bin/brightness.sh = #{monitor} #{level}`
  end

  def reset(monitor)
    `/usr/local/bin/brightness.sh = #{monitor}`
  end

end

def forkoff(command)
  fork do
    exec(command)
  end
end

def monitors
  monitors = `xrandr --listmonitors | awk -F "  " '{print $2}' | xargs`.split
  return monitors
end

action = Brightness.prompt.select("Choose action") do |menu|
  menu.choice "adjust"
  menu.choice "reset"
end

case action
  when "reset"
    monitors.each { |m| Brightness.reset(m) }
  when "adjust"
    choices = monitors.push("all")

    choice = Brightness.prompt.multi_select("select outputs to adjust", choices, default: "all")

    level = Brightness.prompt.slider("brightness", min: 0, max: 1, step: 0.0125, default: 1.0)

    if choice.include?("all")
      monitors.each { |m| Brightness.set(m, level) }
    else
      choice.each { |s| Brightness.set(s, level) }
    end
end
