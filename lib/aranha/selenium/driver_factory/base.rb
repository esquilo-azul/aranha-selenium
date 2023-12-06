# frozen_string_literal: true

require 'aranha/selenium/driver_options'
require 'eac_ruby_utils/core_ext'

module Aranha
  module Selenium
    class DriverFactory
      class Base
        # @!attribute [r] options
        #   @return [Aranha::Selenium::DriverOptions]

        # @!method initialize(options)
        #   @param options [Aranha::Selenium::DriverOptions]
        common_constructor :options do
          self.options = ::Aranha::Selenium::DriverOptions.assert(options)
        end

        def build
          raise 'Must be overrided'
        end

        ::Aranha::Selenium::DriverOptions.lists.option.each_value do |option_key|
          method_name = option_key.to_s
          method_name = "#{method_name}?" if ::Aranha::Selenium::DriverOptions::BOOLEAN_OPTIONS
                                               .include?(option_key)
          define_method method_name do
            options.send(method_name)
          end
        end
      end
    end
  end
end
