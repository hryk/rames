require 'forwardable'
require 'rames/util'

module Rames
  class Processor
    include Util
    attr_accessor :name, :parent, :is_root, :matchers, :container
    def_delegators :@container, :root_processor, :to_processor, :to_repository

    def initialize(name, &block)
      @is_root  = (name == :root) ? true : false
      root_processor self if @is_root
      @matchers = []
      regist_matchers &block
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

    private

    def regist_matchers(&block)
      self.instance_eval &block
    end

    def matcher(def_matcher, &behaviour_block)
       if def_matcher.is_a? Symbol
         name = def_matcher.to_s
         klass_name = load_matcher name
         matcher_object = constnize(klass_name).new
       elsif def_matcher.is_a? Hash
         name = def_matcher.keys.first
         klass_name = load_matcher name.to_s
         matcher_object = constnize(klass_name)
         .new(def_matcher.value(name))
       end 

       self.instance_eval &behaviour_block # Load mailet.

       matcher_object.bake(self, &behaviour_block)

       @matchers << matcher_object
    end

  end
end
