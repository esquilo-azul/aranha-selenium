# frozen_string_literal: true

require 'eac_ruby_utils/boolean'
require 'eac_ruby_utils/core_ext'
require 'tmpdir'

module Aranha
  module Selenium
    class DriverOptions
      class << self
        # @return [Aranha::Selenium::DriverOptions]
        def instance
          @instance ||= new
        end
      end

      DEFAULT_DOWNLOADS_DIR = ::File.join(::Dir.tmpdir, 'aranha_downloads_dir')
      DEFAULT_ACCEPT_INSECURE_CERTS = false
      DEFAULT_HEADLESS = false
      DEFAULT_PROFILE_DIR = nil
      DEFAULT_USER_AGENT = nil

      %w[accept_insecure_certs downloads_dir headless profile_dir user_agent].each do |key|
        define_method(key) { send("#{key}_option").value }
        define_method("#{key}=") { |user_value| send("#{key}_option").user_value = user_value }
        define_method("#{key}_option") do
          options[key] ||= ::Aranha::Selenium::DriverOptions::Option.new(self, key)
        end
      end

      # @return [Aranha::Selenium::DriverOptions::Option]
      def headless_option
        options['headless'] ||= ::Aranha::Selenium::DriverOptions::Option.new(
          self, 'headless', ->(v) { ::EacRubyUtils::Boolean.parse(v) }
        )
      end

      private

      def options
        @options ||= {}
      end

      require_sub __FILE__
    end
  end
end
