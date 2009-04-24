module Rames
  module Util

    def get_mailet(name)
      get_components('mailet',name)
    end

    def get_matcher(name)
      get_components('matcher',name)
    end

    def get_components(type, name)
      under_score_name = "rames/#{type}/#{name}"
      constnize( camelize under_score_name).new
    end

    def load_matcher(name)
      return load_component('matcher', name)
    end

    def load_mailet(name)
      return load_component('mailet', name)
    end

    def load_component(type, name)
      begin
        require "rames/#{type}/#{name}"
      rescue LoadError => e
        require "#{RAMES_ROOT}/app/#{type}/#{name}"
      ensure
        path = "rames/#{type}/#{name}"
      end

      return camelize path
    end

    def constnize(string)
      string.sub(/^::/,'').
        split("::").inject(Object){|scope,name|
        scope.const_get(name)
      }
    end

    # from Rails
    # vendor/rails/activesupport/lib/active_support/inflector.rb
    def underscore(camel_cased_word)
      camel_cased_word.to_s.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end

    def camelize(lower_case_and_underscored_word, first_letter_in_uppercase = true)
      if first_letter_in_uppercase
        lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
      else
        lower_case_and_underscored_word.first + camelize(lower_case_and_underscored_word)[1..-1]
      end
    end

  end
end

