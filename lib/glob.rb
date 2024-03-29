#!/usr/bin/env ruby
# frozen_string_literal: true

module Glob
  module_function

  FD = "/usr/bin/fd"
  FD_OPTS = "-a -L --show-errors"

  def cmd
    TTY::Command.new(output: $logger, 2 => 1)
  end

  def fd(pattern,type,path)
    cmd.run("#{FD} #{pattern} -t #{type} #{FD_OPTS} #{path}", only_output_on_error: true)
  end

  # force an encoding and replace marks with nothing
  def fix_encoding(input)
    output = input.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
  end

  def folders(path,regex=nil)
    regex = "." if regex.nil?
    results = fd(regex, "d", path)
    folders = fix_encoding(results.out)
    return folders.split("\n").sort
  end

  def files(path,regex=nil)
    regex = "." if regex.nil?
    results = cmd.run("#{FD} #{regex} -t f #{FD_OPTS} #{path}", :err => :out, only_output_on_error: true)

    files = fix_encoding(results.out)
    return files.split("\n").sort
  end

  def sounds(path)
    return Dir.glob(File.join(path, "**/*{,/*/**}.{wav,flac,mp3,aiff,ogg,wma,opus,m4a}"))
  end

  def videos(path)
    return Dir.glob(File.join(path, "**/*{,/*/**}.{mp4,mkv}"))
  end

  def soundfonts(path)
    return Dir.glob(File.join(path, "**/*{,/*/**}.{sfz,sf2,gig}"))
  end

  def midi(path)
    return Dir.glob(File.join(path, "**{,/*/**}/*.{mid,midi}"))
  end

end
