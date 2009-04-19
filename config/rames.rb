# Rames configuration sample.
processor :root do

    mailet :match => [ All ] , PostMasterAlias

    mailet :match => [ Relaylimit , 30 ], Null

    mailet :match => [ HasMailAttributeWithValue , { org.apache.james.infected => true } ] do
        notice "this is SPAM!!!!"
        to_processor :spam
    end

    mailet :match => [ Tsukurepost ] do
        to_processor :tsukurepost
    end

end

processor :spam do
    mailet :match => [ All ] do
        to_repository 'file:///var/mail/spam'
    end
end

processor :tsukurepost do
    mailet :match => [ Bodylength , '<=', 32 ], Tsukurepost => :body_length # Matcher::Tsukurepost::NotifyError::BodyLength
    mailet :match => [ HasAtachment , false ] , Tsukurepost => :no_attach
    mailet :match => [ HasTicket ]            , Tsukurepost => :create           #Tsukurepost::Create
end

processor :error do
    mailet :match => [ All ] do
        to_repository 'file:///var/mail/error'
    end
end

