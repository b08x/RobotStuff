#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bigdecimal'
require 'open3'
require 'tty-command'

$soxtemp = File.join("/tmp", "soxtemp")

unless Dir.exist?($soxtemp)
  FileUtils.mkpath($soxtemp)
end

module SoxStuff
  module_function

  def decibel_convertor(dB)
    # convert decibel reading from sox
    # 0 - 1 with 1 being the loudest
    dBFs_range = (-80.00..-0.00)
    vol = ( (dB - dBFs_range.min) / (dBFs_range.max - dBFs_range.min) ) * (1 - 0) + 0
    return vol.round(3)
  end

  # Description of #info
  #
  # @args path [Type] describe_path_here
  # @return [Type] description_of_returned_object
  def info(path)
    # Some sox commands print out to std err?!
    info_out, info_err = Open3.capture3("sox --info '#{path}'")
    stats_out, stats_err = Open3.capture3("sox -V2 '#{path}' -n stats")
    stat_out, stat_err = Open3.capture3("sox '#{path}' -n stat")
    res = {}
    (info_out.lines + info_err.lines + stats_out.lines + stats_err.lines + stat_out.lines + stat_err.lines).each do |line|
      match = line.match(/\A(.+?)\s*(:|\s)\s+(.*)\Z/)
      if match
        key = match[1]
        key = key.downcase
        key = key.gsub(/[^a-z0-9_]+/, " ")
        key = key.gsub(/\s+/, " ")
        key = key.strip
        key = key.gsub(/\s+/, "_")
        key = key.to_sym

        begin
          res[key] = BigDecimal('#{match[3]}')
        rescue
          res[key] = match[3]
        end
      end
    end

    return res
  end

  def trim(source,output)
    args = "silence -l 1 0.1 1% -1 4.0 1%"
    `sox #{source} #{output} #{args}`
  end

  def samplerate(source,output)
    args = "rate -v -I -b 90 48k highpass 15"
    `sox -V -G #{source} -b 24 #{output} #{args}`
  end

  def fade(source,output)
    args = "fade t 0.01 0 0.01"
    `sox -V2 #{source} #{output} #{args}`
  end

  # def convert(infile,outfile)
  #   Soundbot.cmd("#{$sox} -V2 #{infile} #{outfile}")
  # end
  #
  # def dcfix(wavfile)
  #   Soundbot.cmd("#{$ecafixdc} #{wavfile}")
  # end
  #
  # def hpf(source,output,cutoff=20)
  #   hpf = "highpass -1 #{cutoff}"
  #   Soundbot.cmd("#{$sox} -V2 #{source} #{output} #{hpf}")
  # end
  #
  # def lpf(source,output,cutoff=20000)
  #   hpf = "lowpass -1 #{cutoff}"
  #   Soundbot.cmd("#{$sox} -V2 #{source} #{output} #{lpf}")
  # end
  #


end
