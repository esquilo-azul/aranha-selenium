# frozen_string_literal: true

require 'aranha/selenium/driver_options'
require 'aranha/selenium/executables'
require 'eac_ruby_utils/core_ext'

module Aranha
  module Selenium
    class DriverFactory
      class << self
        def create_driver(options = {})
          new(options).create_driver
        end
      end

      DRIVERS = {
        chrome: :chromedriver,
        firefox: :geckodriver
      }.freeze

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
        DRIVERS.each do |driver, executable|
          return driver if ::Aranha::Selenium::Executables.send(executable).exist?
        end

        raise "No driver found (#{DRIVERS.value.join(', ')})"
      end

      # @return [Aranha::Selenium::DriverOptions]
      def driver_options
        ::Aranha::Selenium::DriverOptions.default.merge(
          ::Aranha::Selenium::DriverOptions.assert(options.except(:driver))
        )
      end

      require_sub __FILE__
    end
  end
end
