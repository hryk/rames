module Rames
  module Util

    def load_matcher(name)
      return load_component('matcher', name)
    end

    def load_mailet(name)
      return load_component('mailet', name)
    end

    def load_component(type, name)
      begin
        require "rames/#{type}/#{name}"
      rescue
        require "#{RAMES_ROOT}/app/#{type}/#{name}"
      ensure
        path = "rames/#{type}/#{name}"
      end

      return to_const path
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

