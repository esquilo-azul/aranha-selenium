# frozen_string_literal: true

require 'eac_ruby_utils/boolean'
require 'eac_ruby_utils/core_ext'
require 'tmpdir'

module Aranha
  module Selenium
    class DriverOptions
      class << self
        # @return [Aranha::Selenium::DriverOptions]
        # @param [Aranha::Selenium::DriverOptions, Hash]
        def assert(source)
          return source if source.is_a?(self)

          new(source)
        end

        # @return [Aranha::Selenium::DriverOptions]
        def default
          @default ||= new
        end
      end

      enable_listable
      lists.add_symbol :option, :accept_insecure_certs, :downloads_dir, :headless, :profile_dir,
                       :profile_name, :user_agent
      BOOLEAN_OPTIONS = [OPTION_ACCEPT_INSECURE_CERTS, OPTION_HEADLESS].freeze

      DEFAULT_DOWNLOADS_DIR = ::File.join(::Dir.tmpdir, 'aranha_downloads_dir')
      DEFAULT_ACCEPT_INSECURE_CERTS = false
      DEFAULT_HEADLESS = false
      DEFAULT_PROFILE_DIR = nil
      DEFAULT_PROFILE_NAME = nil
      DEFAULT_USER_AGENT = nil

      OPTIONS_SANITIZERS = {}.freeze

      # @param user_values [Hash]
      def initialize(user_values = {})
        user_values.each { |k, v| send("#{k}=", v) }
      end

      compare_by :to_h

      lists.option.each_value do |key|
        define_method(key) { send("#{key}_option").value }
        define_method("#{key}=") { |user_value| send("#{key}_option").user_value = user_value }

        option_proc = OPTIONS_SANITIZERS[key]
        if BOOLEAN_OPTIONS.include?(key)
          option_proc = proc { |v| ::EacRubyUtils::Boolean.parse(v) } if option_proc.blank?
          define_method("#{key}?") { send(key) }
        end

        define_method("#{key}_option") do
          options[key] ||= ::Aranha::Selenium::DriverOptions::Option.new(self, key, option_proc)
        end
      end

      # @param other [Aranha::Selenium::DriverOptions]
      # @return [Aranha::Selenium::DriverOptions]
      def merge(other)
        self.class.assert(to_h.merge(other.to_h))
      end

      # @return [Hash]
      def to_h
        options.values.reject { |opt| opt.user_value.nil? }.to_h { |opt| [opt.key, opt.user_value] }
      end

      private

      def options
        @options ||= {}
      end

      require_sub __FILE__
    end
  end
end
