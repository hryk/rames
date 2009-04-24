class Logging < Rames::Mailet::Base
    def service(mail) 
        puts mail.to_s
    end
end
