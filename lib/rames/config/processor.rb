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
      def match(condition , &block)
        matcher_def     = condition.keys.first   # matcher_def is Symbol or Array.
        mailet_def = condition[matcher_def]

        # Matcher with arguments
        if matcher_def.is_a? Array
          matcher_name = matcher_def.shift
          matcher_args = matcher_def
          # matcher with no args.
        elsif matcher_def.is_a? Symbol
          matcher_name = matcher_def.to_s
          matcher_args = []
        else
          # die
          raise "Matcher have to be an Array or a Symbol."
        end

        @pair_stack.push [ load_matcher(matcher_name,matcher_args), mailet_def ]
      end

      def mailet(mailet_to)
        p mailet_to
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
