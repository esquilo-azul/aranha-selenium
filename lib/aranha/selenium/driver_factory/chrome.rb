# frozen_string_literal: true

require 'aranha/selenium/driver_factory/base'
require 'selenium-webdriver'

module Aranha
  module Selenium
    class DriverFactory
      class Chrome < ::Aranha::Selenium::DriverFactory::Base
        def build
          ::Selenium::WebDriver.for :chrome, options: chrome_options
        end

        private

        def chrome_options
          r = ::Selenium::WebDriver::Chrome::Options.new
          chrome_arguments.each { |arg| r.add_argument(arg) }
          r.add_preference(:download, prompt_for_download: false, default_directory: downloads_dir)
          r
        end

        def chrome_arguments
          r = %w[--disable-popup-blocking --disable-translate
                 --disable-blink-features=AutomationControlled]
          r << '--ignore-certificate-errors' if accept_insecure_certs?
          r << '--headless' if headless?
          r << "--user-agent=#{user_agent}" if user_agent.present?
          r << "--user-data-dir=#{profile_dir}" if profile_dir.present?
          r
        end
      end
    end
  end
end
