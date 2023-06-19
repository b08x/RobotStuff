#!/usr/bin/env ruby

require 'pty'
require 'expect'

def activate_transport

  PTY.spawn("jack_transport") do |r,w,pid|
    w.sync = true
    $expect_verbose = true
    r.expect(/jack_transport> /)
    w.printf("activate\n")
    r.expect(/jack_transport> /)
    w.printf("master\n")
    r.expect(/jack_transport> /)
    w.printf("quit\n")
  end

end

def set_bpm(t)

  PTY.spawn("jack_transport") do |r,w,pid|
    w.sync = true
    $expect_verbose = true
    r.expect(/jack_transport> /)
    w.printf("tempo #{t}\n")
    r.expect(/jack_transport> /)
    w.printf("quit\n")
  end

end

def stop_transport
  PTY.spawn("jack_transport") do |r,w,pid|
    w.sync = true
    $expect_verbose = true
    r.expect(/jack_transport> /)
    w.printf("stop\n")
    r.expect(/jack_transport> /)
    w.printf("quit\n")
  end
end

def start_transport
  PTY.spawn("jack_transport") do |r,w,pid|
    w.sync = true
    $expect_verbose = true
    r.expect(/jack_transport> /)
    w.printf("play\n")
    r.expect(/jack_transport> /)
    w.printf("quit\n")
  end
end

#set_bpm(60)
#start_transport
#stop_transport
