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

      def create_driver
        driver_class.new(driver_options).build
      end

      def driver_name
        (driver_name_from_options || default_driver_name).to_s
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
        ::Aranha::Selenium::DriverOptions.default.merge(options)
      end

      protected

      attr_writer :driver_name_from_options
    end
  end
end
