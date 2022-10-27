# frozen_string_literal: true

module Aranha
  module Selenium
    class Session < ::SimpleDelegator
      module Wait
        WAIT_DEFAULT_TIMEOUT = 15

        def wait_default_timeout
          WAIT_DEFAULT_TIMEOUT
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

        private

        def wait_uncached
          ::Selenium::WebDriver::Wait.new(timeout: wait_default_timeout)
        end
      end
    end
  end
end
