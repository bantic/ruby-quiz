begin
  require "rspec"
rescue LoadError
  require "rubygems"
  require "rspec"
end

$stdout.sync = true

Dir[ File.dirname(__FILE__) + "/*/*.rb" ].select {|file| file =~ /\d+\.rb$/ || file =~ /_quiz\.rb$/ }.each do |file|
  require file
end