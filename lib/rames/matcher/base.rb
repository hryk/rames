module Rames
  module Matcher
    class Base
      attr_accessor :processor, :container, :mail, :behaviour

      def initialize
      end

      def match(mail)
        @mail = mail
      end

      def bake(&block)
        @behaviour = &block
      end

      def behave
        behaviour.instance_eval
      end

      private

      def mailet(name)
        
      end

      def to_repository(uri)
        Rames::Config::Repository.instance.repository(uri).put(@mail)
      end

      def to_processor(name)
        Rames::Config::Container.instance.processor(name).run @mail
      end

    end
  end
end
