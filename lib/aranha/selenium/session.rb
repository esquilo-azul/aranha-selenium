# frozen_string_literal: true

require 'aranha/selenium/driver_factory'
require 'eac_ruby_utils/core_ext'
require 'selenium-webdriver'

module Aranha
  module Selenium
    class Session < ::SimpleDelegator
      require_sub __FILE__, include_modules: true
      enable_simple_cache
      attr_reader :downloads

      def initialize(options = {})
        @downloads = Downloads.new
        super(
          ::Aranha::Selenium::DriverFactory.create_driver(
            options.merge(download_dir: @downloads.dir)
          )
        )
      end

      def current_source
        element = find_element(xpath: '/html[1]')
        raise 'Root element not found' unless element

        s = element.attribute('innerHTML')
        "<html>\n#{s}\n</html>\n"
      end

      private

      def element_click(element)
        element.click
        element
      rescue ::Selenium::WebDriver::Error::ElementClickInterceptedError,
             ::Selenium::WebDriver::Error::ElementNotInteractableError,
             ::Selenium::WebDriver::Error::StaleElementReferenceError
        nil
      end
    end
  end
end
