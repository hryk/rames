require 'rames/config/processor'

module Rames
  module Config
    # Processor Container
    class Container
      attr_accessor :processor_tree , :root_processor

      def initialize
        @processor_tree = Hash.new
      end

      # def disptch_mail(mail)
      #
      # end

      def load_processors(conf_path)
        conf = ''

        open(conf_path) do |f|
          conf = f.readlines.join
        end

        self.instance_eval conf

        raise "Define root processor.Abort." if @root_processor.nil?
      end 

      private

      def processor(name, &block)
        if name == :root
          @root_processor = Rames::Config::Processor.new(block)
        else
          @processor_tree[name] = Rames::Config::Processor.new(block)
        end
      end

    end
  end
end
