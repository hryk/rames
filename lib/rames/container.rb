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

      raise "Define root processor.Abort." if @root_processor.nil?
    end

    def processor(name, &block)
      if name == :root
        @root_processor = Rames::Processor.new(name, &block)
      else
        @processor_tree[name] = Rames::Processor.new(name, &block)
      end
    end

  end
end

