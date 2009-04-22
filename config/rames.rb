# Rames configuration sample.
processor :root do

    mailet :match => [ All ] , PostMasterAlias

    mailet :match => [ Relaylimit , 30 ], Null

    mailet :match => [ HasMailAttributeWithValue , { org.apache.james.infected => true } ] do
        notice "this is SPAM!!!!"
        to_processor :spam
    end
end

processor :spam do
    mailet :match => [ All ] do
        to_repository 'file:///var/mail/spam'
    end
end

processor :error do
    mailet :match => [ All ] do
        to_repository 'file:///var/mail/error'
    end
end

