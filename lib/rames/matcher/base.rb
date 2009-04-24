require 'forwardable'
module Rames
  module Matcher
    class Base
      extend Forwardable
      include Rames::Util
      attr_accessor :processor, :mail, :behaviour, :args

      def initialize(args=nil)
        @args = args unless args.nil?
      end

      def match(mail)
        @mail = mail
      end

      def bake(processor, &block)
        @behaviour = block
        @processor = processor
      end

      def behave(mail)
        @mail = mail
        point = catch( :exit_behaviour ){
          instance_eval &@behaviour
        }
        return_mail = @mail
        @mail = nil

        {
         :mail => return_mail,
         :to   => point
        }

      end

      private

      def mailet(def_mailet)
        method = 'service'
        if def_mailet.is_a? Symbol
          name = def_mailet.to_s
        elsif def_mailet.is_a? Hash
          name = def_mailet.keys.first.to_s
          method = def_mailet.value(name)
        end
        puts "sending #{method}"
        puts get_mailet(name)
        get_mailet(name).send method, @mail
      end

      # Forward ...
      #
      def to_repository(uri)
         throw :exit_behaviour , [:to_repository, name]
      end

      def to_processor(name)
         throw :exit_behaviour , [:to_processor, name]
      end

    end
  end
end
