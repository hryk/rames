class SubjectIs < Rames::Matcher::Base
  def match(mail)
      puts "matcher subject_is invoked"
      text = @args
      if /#{text}/o =~ mail.subject
          mail.to_addrs
      else
          nil
      end
  end
end
