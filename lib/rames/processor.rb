require 'forwardable'
require 'rames/util'
require 'rames/matcher/base'
require 'rames/mailet/base'

module Rames
  class Processor
    include Util
    extend Forwardable
    attr_accessor :name, :parent, :is_root, :matchers, :container
    def_delegators :@container, :set_root_processor #, :to_processor, :to_repository

    def initialize(name, &block)
      @is_root  = (name == :root) ? true : false
      set_root_processor self if @is_root
      @matchers = []
      regist_matchers &block
    end

    def run(mail)
      @matchers.each {|m|
        recipients = m.match(mail)

        if    recipients.size == 0
          next
        elsif recipients.size == 1
          res = m.behave mail
          unless res.nil?
              mail =  res[:mail]
              throw :exit_processor, res[:to] unless res[:to].nil?
          end
        else

        end

      }
    end

    private

    def regist_matchers(&block)
      self.instance_eval &block
    end

    def match(def_matcher, &behaviour_block)
       if def_matcher.is_a? Symbol
         name = def_matcher.to_s
         klass_name = load_matcher name
         matcher_object = constnize(klass_name).new
       elsif def_matcher.is_a? Hash
         name = def_matcher.keys.first
         puts "########### #{name}"
         klass_name = load_matcher name.to_s
         matcher_object = constnize(klass_name).new(def_matcher[name])
       end 

       self.instance_eval &behaviour_block # Load mailet.

       matcher_object.bake(self, &behaviour_block)
       @matchers << matcher_object
    end

    def mailet(def_mailet)
        if def_mailet.is_a? Symbol
            name = def_mailet
            klass_name = load_mailet name.to_s
        elsif def_mailet.is_a? Hash
            name = def_mailet.keys.first
            klass_name = load_mailet name.to_s
        end
    end

    def to_repository(uri)
    end

    def to_processor(name)
    end

  end
end
