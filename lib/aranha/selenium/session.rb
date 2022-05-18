# frozen_string_literal: true

require 'aranha/selenium/driver_factory'

module Aranha
  module Selenium
    class Session < ::SimpleDelegator
      attr_reader :downloads, :wait

      def initialize(options = {})
        @downloads = Downloads.new
        @wait = ::Selenium::WebDriver::Wait.new(timeout: 15)
        super(
          ::Aranha::Selenium::DriverFactory.create_driver(
            options.merge(download_dir: @downloads.dir)
          )
        )
      end

      # @return [Selenium::WebDriver::Element, nil]
      def find_element(*args, &block)
        return args.first if args.count >= 1 && args.first.is_a?(::Selenium::WebDriver::Element)

        __getobj__.find_element(*args, &block)
      end

      def find_or_not_element(find_element_args)
        r = find_elements(find_element_args)
        r.any? ? r.first : nil
      end

      def select_option(field, value, *find_element_args)
        select = find_element(*find_element_args)
        option = ::Selenium::WebDriver::Support::Select.new(select)
        option.select_by(field, value)
      end

      def select_option_by_text(text, *find_element_args)
        select_option(:text, text, *find_element_args)
      end

      def select_option_by_value(value, *find_element_args)
        select_option(:value, value, *find_element_args)
      end

      def wait_for_click(find_element_args)
        wait.until do
          element = find_element(find_element_args)
          element ? element_click(element) : nil
        end
      end

      def wait_for_element(find_element_args)
        wait.until { find_element(find_element_args) }
      end

      def wait_for_download
        initial_downloads = downloads.current
        yield
        new_downloads = []
        wait.until do
          new_downloads = downloads.current - initial_downloads
          new_downloads.any?
        end
        new_downloads.first
      end

      def wait_for_url_change(&block)
        previous_url = current_url
        block&.call

        wait.until { current_url != previous_url }
      end

      def current_source
        element = find_element(xpath: '/html[1]')
        raise 'Root element not found' unless element

        s = element.attribute('innerHTML')
        "<html>\n#{s}\n</html>\n"
      end

      class Downloads
        attr_reader :dir

        def initialize
          @dir = ::Dir.mktmpdir
        end

        def current
          Dir.glob("#{dir}/**/*")
        end
      end

      private

      def element_click(element)
        element.click
        element
      rescue ::Selenium::WebDriver::Error::ElementClickInterceptedError,
             ::Selenium::WebDriver::Error::ElementNotInteractableError
        nil
      end
    end
  end
end
