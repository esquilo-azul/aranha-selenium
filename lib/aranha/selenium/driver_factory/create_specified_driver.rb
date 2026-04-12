# frozen_string_literal: true

module Aranha
  module Selenium
    class DriverFactory
      class CreateSpecifiedDriver
        acts_as_instance_method
        common_constructor :factory, :driver_name, :options

        # @return [Aranha::Selenium::DriverFactory::Base]
        def result
          driver_class.new(driver_options).build
        end

        protected

        # @return [Class<Aranha::Selenium::DriverFactory::Base>]
        def driver_class
          driver_class_name = driver_name.to_s.classify
          Aranha::Selenium::DriverFactory.const_get(driver_class_name)
        rescue NameError
          raise "Unknown Aranha Selenium driver: \"#{driver_name}\" " \
                "(Class \"Aranha::Selenium::DriverFactory::#{driver_class_name}\" not found)"
        end

        # @return [Aranha::Selenium::DriverOptions]
        def driver_options
          ::Aranha::Selenium::DriverOptions.default.merge(options)
        end
      end
    end
  end
end
