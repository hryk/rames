module Rames
  module Config
    class Processor
      attr_accessor :pair_stack

      def initialize( block )
        puts "Initialize Processor Start"
        @pair_stack = Array.new
        self.instance_eval &block
        puts "Initialize Processor End"
      end

      private

      # condition = { matcher_definition => mailet_instance }
      def match(matcher_name , &block)
      end

      def mailet(mailet_to)
      end

      def load_mailet(name, method)
      end

      def load_matcher(name, args)
      end

      def to_processor(processor_name)
      end

      def to_repository(repository_uri)
      end

    end

  end
end
