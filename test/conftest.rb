#!/usr/bin/ruby
require 'rames/container'
require 'rames/processor'
require 'rubygems'
require 'tmail'

# conf = Rames::Config.new(RAMES_ROOT)
# Rames::SpoolManager.run(conf)

RAMES_ROOT = File.expand_path(File.dirname(__FILE__)) + '/../'
puts "ROOT: #{RAMES_ROOT}"
c = Rames::Container.new(ARGV[0])

mail = TMail::Mail.new
mail.subject = 'twit'
mail.body = 'this is test..'
mail.to = 'hello@hryk.info'

c.process(mail)

