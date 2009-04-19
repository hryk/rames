#!/usr/bin/env ruby
require 'optparse'
require 'rames'

# options = { :environment => (ENV['RAILS_ENV'] || "development").dup }
# 
# ARGV.clone.options do |opts|
#     script_name = File.basename($0)
#     opts.banner = "Usage: #{$0} [options]"
#     opts.separator ""
#     opts.on("-e", "--environment=name", String,
#             "Specifies the environment for the runner to operate under (test/development/production).",
#             "Default: development") { |v| options[:environment] = v }
# 
# end

begin
    require File.dirname(__FILE__) + '/../config/boot'
rescue
    RAMES_ROOT = ENV['PWD'] + '/../'
    on_rails   = false
else
    RAMES_ROOT = RAILS_ROOT
    on_rails   = true
    ENV["RAILS_ENV"] = options[:environment]
    RAILS_ENV.replace(options[:environment]) if defined?(RAILS_ENV)

    require RAILS_ROOT + '/config/environment'
end

Rames::SpoolManager.new(
    Rames::Config::SpoolManager.new.load_config( RAMES_ROOT + 'config/rames' )
).service( :port => 8888, :addr => '127.0.0.1' )

