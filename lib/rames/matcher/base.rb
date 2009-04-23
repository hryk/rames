require 'forwardable'
module Rames
  module Matcher
    class Base
      attr_accessor :processor, :mail, :behaviour
#      def_delegator :@processor, :to_processor,  :to_processor_run
#      def_delegator :@processor, :to_repository, :to_repository_run

      def initialize(args=nil)
      end

      def match(mail)
        @mail = mail
      end

      def bake(processor, &block)
        @behaviour = &block
        @processor = processor
      end

      def behave
        behaviour.instance_eval
      end

      private

      def mailet(def_mailet)
        if def_mailet.is_a? Symobol
          load_mailet(name)
        elsif def_mailet.is_a? Hash
          m = get_mailet_instance(name)
        end
      end

      # Forward ...
      #
      def to_repository(uri)
        return { :to_repository => uri }
      end

      def to_processor(name)
        return { :to_processor  => name }
      end

    end
  end
end
