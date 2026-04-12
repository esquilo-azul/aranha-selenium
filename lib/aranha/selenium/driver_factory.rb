# frozen_string_literal: true

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

      attr_reader :driver_name_from_options

      # @!attribute [r] options
      #   @return [Aranha::Selenium::DriverOptions]

      # @!method initialize(options)
      #   @param options [ActiveSupport::HashWithIndifferentAccess]
      common_constructor :options do
        self.options = options.with_indifferent_access
        self.driver_name_from_options = options.delete(:driver)
        self.options = ::Aranha::Selenium::DriverOptions.assert(options)
      end

      # @return [Aranha::Selenium::DriverFactory::Base]
      def create_driver
        create_specified_driver(driver_name, options)
      end

      # @return [String]
      def driver_name
        (driver_name_from_options || default_driver_name).to_s
      end

      # @return [String]
      def default_driver_name
        DRIVERS.each do |driver, executable|
          return driver if ::Aranha::Selenium::Executables.send(executable).exist?
        end

        raise "No driver found (#{DRIVERS.value.join(', ')})"
      end

      protected

      attr_writer :driver_name_from_options

      require_sub __FILE__, require_mode: :kernel
    end
  end
end
