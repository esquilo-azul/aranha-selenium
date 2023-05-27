# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'tmpdir'

module Aranha
  module Selenium
    class DriverFactory
      class Base
        DEFAULT_DOWNLOADS_DIR = ::File.join(::Dir.tmpdir, 'aranha_downloads_dir')
        DEFAULT_ACCEPT_INSECURE_CERTS = false
        DEFAULT_HEADLESS = false
        DEFAULT_USER_AGENT = nil

        class << self
          attr_writer :default_accept_insecure_certs, :default_downloads_dir, :default_headless,
                      :default_user_agent

          def default_downloads_dir
            @default_downloads_dir || DEFAULT_DOWNLOADS_DIR
          end

          def default_accept_insecure_certs
            @default_accept_insecure_certs || DEFAULT_ACCEPT_INSECURE_CERTS
          end

          def default_headless
            @default_headless || DEFAULT_HEADLESS
          end

          def default_user_agent
            @default_user_agent || DEFAULT_USER_AGENT
          end
        end

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
          options[:profile_dir].to_s
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
            ::Aranha::Selenium::DriverFactory::Base.send("default_#{key}")
          end
        end
      end
    end
  end
end
