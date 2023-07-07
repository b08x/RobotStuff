#!/usr/bin/env ruby
# frozen_string_literal: true

module EasySSH
	module_function

	require 'net/ssh'

  USER = ENV["USER"]
  PRIVATEKEY = File.join(ENV["HOME"], ".ssh", "id_rsa")

	#http://stackoverflow.com/a/3386375
    def ssh_exec!(ssh, command)
      stdout_data = ""
      stderr_data = ""
      exit_code = nil
      exit_signal = nil
      ssh.open_channel do |channel|
      	#to resolve "sudo: sorry, you must have a tty to run sudo" have the ssh connection request a psuedo terminal
      	channel.request_pty do |channel, success|
      		raise "could not request pty" unless success

          channel.exec(command) do |ch, success|
              unless success
                abort "FAILED: couldn't execute command (ssh.channel.exec)"
              end

              channel.on_data do |ch,data|
                stdout_data+=data
              end

              channel.on_extended_data do |ch,type,data|
                stderr_data+=data
              end

              channel.on_request("exit-status") do |ch,data|
                exit_code = data.read_long
              end

              channel.on_request("exit-signal") do |ch, data|
                exit_signal = data.read_long
              end
          end
      end
    end
      ssh.loop
      [stdout_data, stderr_data, exit_code, exit_signal]
    end


    def run_remote_command(host, command)
    	# keep in mind that sudo will probably be required....
    	# if this script is run as a user with ssh-keys setup,
      # you need not specify user/keys....

    	#start a session
    	session = Net::SSH.start(host, USER, :keys => [ "#{PRIVATEKEY}"])

      # returning an array of stdout, stderr, exit code|signal
    	ssh_command_output = ssh_exec!(session, command).inspect

      # when calling Net::SSH.start without a block, you must explictly close the session
    	session.close

    	return ssh_command_output

    end

end
