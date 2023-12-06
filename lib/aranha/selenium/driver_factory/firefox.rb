# frozen_string_literal: true

require 'aranha/selenium/driver_factory/base'
require 'selenium-webdriver'

module Aranha
  module Selenium
    class DriverFactory
      class Firefox < ::Aranha::Selenium::DriverFactory::Base
        def build
          ::Selenium::WebDriver.for(
            :firefox,
            options: build_options,
            desired_capabilities: build_capabilities
          )
        end

        private

        def build_args
          r = []
          r << '--headless' if headless?
          r
        end

        def build_capabilities
          caps = {}
          caps[:accept_insecure_certs] = true if accept_insecure_certs?
          ::Selenium::WebDriver::Remote::Capabilities.firefox(caps)
        end

        def build_options
          r = ::Selenium::WebDriver::Firefox::Options.new(args: build_args,
                                                          prefs: build_preferences)
          build_profile.if_present { |v| r.profile = v }
          r
        end

        def build_preferences
          r = {
            'browser.download.dir' => downloads_dir,
            'browser.download.folderList' => 2,
            'browser.download.start_downloads_in_tmp_dir' => true,
            'browser.helperApps.neverAsk.saveToDisk' => auto_download_mime_types.join(';'),
            'pdfjs.disabled' => true
          }
          r['general.useragent.override'] = user_agent if user_agent.present?
          r
        end

        def build_profile
          if profile_name.present?
            ::Selenium::WebDriver::Firefox::Profile.from_name(profile_name)
          elsif profile_dir.present?
            ::FileUtils.mkdir_p(profile_dir)
            ::Selenium::WebDriver::Firefox::Profile.new(profile_dir)
          end
        end

        def auto_download_mime_types
          ::File.read(
            ::File.join(__dir__, 'firefox_auto_download_mime_types')
          ).each_line.map(&:strip)
        end
      end
    end
  end
end
