begin
  require "spec"
rescue LoadError
  require "rubygems"
  require "spec"
end

Dir[ File.dirname(__FILE__) + "/*/*.rb" ].select {|file| file =~ /\d+\.rb$/ }.each do |file|
  require file
end