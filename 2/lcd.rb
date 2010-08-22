#!/usr/bin/env ruby

require File.dirname(__FILE__) + "/2"

if ARGV.index("-s")
  size = ARGV[ARGV.index("-s") + 1].to_i
  text = ARGV[ARGV.index("-s") + 2]
else
  size = LCD::DEFAULT_SIZE
  text = ARGV[0]
end

puts LCD.new(text).print(size)