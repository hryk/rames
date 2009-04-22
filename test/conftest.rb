#!/usr/bin/ruby
require 'rames/config/container'

# conf = Rames::Config.new(RAMES_ROOT)
# Rames::SpoolManager.run(conf)
RAMES_ROOT = File.expand_path(File.dirname(__FILE__)) + '/../'
puts "ROOT: #{RAMES_ROOT}"
c = Rames::Config::Container.new.load_processors(ARGV[0])
