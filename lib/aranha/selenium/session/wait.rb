# frozen_string_literal: true

require 'selenium-webdriver'

module Aranha
  module Selenium
    class Session < ::SimpleDelegator
      module Wait
        WAIT_DEFAULT_TIMEOUT = 15

        def wait(timeout = nil)
          timeout ||= wait_default_timeout
          ::Selenium::WebDriver::Wait.new(timeout: timeout)
        end

        def wait_default_timeout
          WAIT_DEFAULT_TIMEOUT
        end

        # @param find_element_args [Array] Argujments for +Selenium::WebDriver::Find.find_element+.
        # @param timeout [Integer]
        # @return [Selenium::WebDriver::Element]
        # @deprecated Use +element.wait_click+ instead.
        def wait_for_click(find_element_args, timeout = nil, &block)
          find_element_args = [find_element_args] if find_element_args.is_a?(::Hash)
          element(*find_element_args).wait_click(timeout, &block)
        end

        def wait_for_element(find_element_args)
          wait.until { find_element(find_element_args) }
        end

        def wait_for_download(timeout = nil)
          initial_downloads = downloads.current
          yield
          new_downloads = []
          wait(timeout).until do
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
      end
    end
  end
end
