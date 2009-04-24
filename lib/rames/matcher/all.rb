class All < Rames::Matcher::Base
    def match(mail)
      puts 'matcher all invoked'
      mail.to_addrs
    end
end
