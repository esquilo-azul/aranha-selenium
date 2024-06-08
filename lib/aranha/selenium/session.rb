# frozen_string_literal: true

require 'aranha/selenium/driver_options'
require 'aranha/selenium/driver_factory'
require 'eac_ruby_utils/core_ext'
require 'selenium-webdriver'

module Aranha
  module Selenium
    class Session < ::SimpleDelegator
      require_sub __FILE__, include_modules: true, require_mode: :kernel
      enable_simple_cache

      def initialize(options = {})
        super(
          ::Aranha::Selenium::DriverFactory.create_driver(
            options.merge(::Aranha::Selenium::DriverOptions::OPTION_DOWNLOADS_DIR => downloads.dir)
          )
        )
      end

      def current_source
        element = find_element(xpath: '/html[1]')
        raise 'Root element not found' unless element

        s = element.attribute('innerHTML')
        "<html>\n#{s}\n</html>\n"
      end

      # @return [Aranha::Selenium::Session::Downloads]
      def downloads
        @downloads ||= ::Aranha::Selenium::Session::Downloads.new
      end

      # @return [Aranha::Selenium::Session::Element]
      def element(*find_args)
        ::Aranha::Selenium::Session::Element.new(self, find_args)
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
