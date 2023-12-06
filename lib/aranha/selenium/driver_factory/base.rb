# frozen_string_literal: true

require 'aranha/selenium/driver_options'
require 'eac_ruby_utils/core_ext'

module Aranha
  module Selenium
    class DriverFactory
      class Base
        common_constructor :options do
          self.options = options.with_indifferent_access.freeze
        end

        def build
          raise 'Must be overrided'
        end

        ::Aranha::Selenium::DriverOptions.lists.option.each_value do |option_key|
          method_name = option_key.to_s
          method_name = "#{method_name}?" if ::Aranha::Selenium::DriverOptions::BOOLEAN_OPTIONS
                                               .include?(option_key)
          define_method method_name do
            option_value(option_key)
          end
        end

        private

        def option_value(key)
          if options.key?(key)
            options.fetch(key)
          else
            ::Aranha::Selenium::DriverOptions.instance.send(key)
          end
        end
      end
    end
  end
end
