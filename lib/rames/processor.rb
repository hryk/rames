module Rames
  class Processor
    attr_accessor :name, :parent, :is_root, :matchers

    def initialize(name, &block)
      @is_root  = (name == :root) ? true : false
      @matchers = []
    end

    def run(mail)
      @matchers.each { |m|
        recipients = m.match(mail)

        if    recipients.size == 0
          next
        elsif recipients.size == 1
          m.behave mail
        else

        end
      }
    end

    def add_matcher(def_matcher, &block)
    end

  end
end
