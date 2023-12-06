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

        def downloads_dir
          option_value(:downloads_dir)
        end

        def accept_insecure_certs?
          option_value(:accept_insecure_certs)
        end

        def headless?
          option_value(:headless)
        end

        def profile_dir
          option_value(:profile_dir)
        end

        def profile_name
          options[:profile_name]
        end

        def user_agent
          option_value(:user_agent)
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
