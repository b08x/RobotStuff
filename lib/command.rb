#!/usr/bin/env ruby
# frozen_string_literal: true

require 'tty-command'

module RobotStuff
  module_function

  module Command
    module_function

    def run(*args)
      cmd = TTY::Command.new(printer: :pretty)
      result = cmd.run(args.join(' '), only_output_on_error: true)
      return result
    end

    # use this if captured output is desired...
    def tty(*args)

      cmd = TTY::Command.new(output: $logger, uuid: false, timeout: 15)

      begin
        out, err = cmd.run(args.join(' '), only_output_on_error: true)
      rescue TTY::Command::ExitError => e
        $logger.debug "#{e} #{args}"
        exit
      rescue TTY::Command::TimeoutExceeded => e
        $logger.debug "#{e} #{args}"
      ensure
        results = out
      end

    end

    # Execute system command with shell aliasing on
    def zsh(*args)
      zsh = "zsh -lc 'source ~/.zshrc && setopt aliases'"

      tty("#{zsh} && #{args.join(' ')}")
    end

    def open(*args)
      require 'open3'
      options = args[-1].is_a?(Hash) ? args.pop : {}

      fork do
        stdin, stdout, stderr = Open3.popen3(*args)
        options[:error] ? stderr.read : stdout.read
      end

    end

    def status(service)
      `pgrep -l #{service}`.chomp
    end

    def forkoff(command)
      fork do
        exec(command)
      end
    end

  end # end Command class
end
