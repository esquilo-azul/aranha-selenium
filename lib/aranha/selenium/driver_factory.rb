# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Aranha
  module Selenium
    class DriverFactory
      class << self
        def create_driver(options = {})
          new(options).create_driver
        end
      end

      # @!attribute [r] options
      #   @return [ActiveSupport::HashWithIndifferentAccess]

      # @!method initialize(options)
      #   @param options [ActiveSupport::HashWithIndifferentAccess]
      common_constructor :options do
        self.options = options.with_indifferent_access.freeze
      end

      def create_driver
        driver_class.new(driver_options).build
      end

      def driver_name
        (options[:driver] || default_driver_name).to_s
      end

      def driver_class
        Aranha::Selenium::DriverFactory.const_get(driver_name.classify)
      rescue NameError
        raise "Unknown Aranha Selenium driver: \"#{driver_name}\" " \
              "(Class \"Aranha::Selenium::DriverFactory::#{driver_name.classify}\" not found)"
      end

      def default_driver_name
        :firefox
      end

      def driver_options
        options.except(:driver)
      end

      require_sub __FILE__
    end
  end
end
