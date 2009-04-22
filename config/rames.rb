# Rames configuration sample.
#
# Root Processor
processor :root do

  # to_processor, to_repository  => カレントプロセサの処理は終了
  # mailet -> matchして処理しても続行

  #
  # Matcher that catch all mail.
  # Matcher class
  #  - Rames::Matcher::All
  #    builtin (rames/matcher/all.rb) or user-defined (app/matcher/all.rb)
  # Mailet class
  #  - Rames::Mailet::PostMasterAlias
  #    builtin (rames/mailet/post_master_alias.rb)
  #    or user-defined (app/matcher/post_master_alias.rb)
  match :all do
    mailet :post_master_alias
    mailet :logging
  end

  # for demonstration
  match :subject_is => 'twit' do
    mailet :post_twitter
  end

  # Matcher with argument
  # Matcher class
  #  - Rames::Matcher::RelayLimit
  #    matcher/relay_limit.rb
  # Matcher Call
  #  # Rames::Matcher::RelayLimit.new.match(30)
  # Mailet class
  #  - Rames::Mailet::Discard
  #    mailet/discard.rb
  # Mailet Call
  # # Rames::Mailet::Discard.new.service(mail)
  match :relay_limit =>  30 do
    mailet :discard 
  end

  # You can call method instead of 'searvice'
  # Matcher class
  #  - Rames::Matcher::AddressIs
  #    matcher/address_is.rb
  # Matcher Call
  #  # Rames::Matcher::AddressIs.new.match(/@hryk\.info/)
  # Mailet class
  #  - Rames::Mailet::MyMailet
  #    mailet/my_mailet.rb
  # Mailet Call
  # # Rames::Mailet::MyMailet.new.to_mobile(mail)
  match(:address_is => /@hryk\.info/) do
    mailet :my_mailet => :to_mobile
  end

  # Redirect another processor
  # Processor call
  #  Rames::Container#redirect(:spam, mail)
  #  then...
  #  Rames::Processor#run(mail)
  match :spam_filter do
    to_processor :spam
  end

  # Inline Mailet
  match  :relay_limit => 30 ] do
    lambda { |mail| puts "#{mail}" }
  end

end

processor :spam do
  # Return mail to repository
  # repository call
  #  mail.return_repository('respository_uri')
  #  then...
  #  Rames::Processor#run(mail)
  #  ??????
  match(  :all ) do
    to_repository 'file:///var/mail/spam'
  end
end

