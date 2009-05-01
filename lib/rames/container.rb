module Rames
  class Container
    attr_accessor :processor_tree, :root_processor

    def initialize(conf_path)
      puts "#{conf_path} read"
      @processor_tree = Hash.new
      read_config(conf_path)
    end

    def process(mail)
      res = catch(:exit_processor) {
        @root_processor.run(mail)
      }
    end

    def set_root_processor(processor)
        @root_processor = processor
    end

    private

    def read_config(conf_path)
      conf = ''

      open(conf_path) do |f|
        conf = f.readlines.join
      end

      begin
        self.instance_eval conf
      rescue => e
        puts e
        puts e.backtrace.join("\n")
      end

      raise "Define root processor." if @root_processor.nil?
    end

    def processor(name_sym , &block)
        @processor_tree[name_sym] = Rames::Processor.new(name_sym, &block)
    end

  end
end

