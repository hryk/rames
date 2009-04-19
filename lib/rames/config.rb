module Rames
    module Config
        class SpoolManager
            attr_accessor :procesor_tree
            def initialize
                @processor_tree = Rames::ProcessorTree.new
            end

            def load_config(config_path)
                require 'config_path' 
            end

            private

            def processor(name, &block)
                new_processor = Rames::Processor.new( name, block )
            end

        end
    end
end
