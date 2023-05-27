# frozen_string_literal: true

require 'aranha/selenium/driver_factory'
require 'eac_ruby_utils/core_ext'

module Aranha
  module Selenium
    class Defaults
      class Option
        common_constructor :owner, :key, :sanitizer, default: [nil] do
          self.key = key.to_sym
        end
        attr_accessor :user_value

        # @return [String]
        def constant_name
          "default_#{key}".upcase
        end

        # @return [Object]
        def default_value
          owner.class.const_get(constant_name)
        end

        # @return [String]
        def envvar_name
          "aranha_selenium_#{key}".upcase
        end

        # @return [Object]
        def value
          sanitized_value do
            next ENV.fetch(envvar_name) if ENV.key?(envvar_name)
            next user_value unless user_value.nil?

            default_value
          end
        end

        private

        def sanitized_value(&block)
          r = block.call
          sanitizer.present? ? sanitizer.call(r) : r
        end
      end
    end
  end
end
