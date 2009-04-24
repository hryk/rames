require 'rubygems'
require 'twitter'
class PostTwitter < Rames::Mailet::Base
  def service(mail)
    puts "Twitter Mailet invoked"
    body = mail.body
    httpauth = Twitter::HTTPAuth.new('account', 'pass')
    base = Twitter::Base.new(httpauth)
    base.update(mail.body)
  end
end
