# frozen_string_literal: true

module Aranha
  module Selenium
    class DriverFactory
      class << self
        def create_driver(options = {})
          new(options).create_driver
        end
      end

      DRIVERS = %i[chrome firefox].freeze

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
        if driver_name_from_options.present?
          create_specified_driver(driver_name_from_options, options)
        else
          create_unspecified_driver
        end
      end

      # @return [Aranha::Selenium::DriverFactory::Base]
      def create_unspecified_driver
        DRIVERS.each do |e|
          return create_specific_driver(e, options)
        rescue Selenium::WebDriver::Error::SessionNotCreatedError
          # do nothing
        end

        raise "No driver available (Tried: #{DRIVERS.join(', ')})"
      end

      protected

      attr_writer :driver_name_from_options

      require_sub __FILE__, require_mode: :kernel
    end
  end
end
