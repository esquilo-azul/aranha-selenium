# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Aranha
  module Selenium
    class Session < ::SimpleDelegator
      class Element
        common_constructor :session, :find_args

        # @return [Selenium::WebDriver::Element, nil]
        def find
          r = session.find_elements(*find_args)
          r.any? ? r.first : nil
        end

        # @return [Selenium::WebDriver::Element]
        # @raise [Selenium::WebDriver::Error::NoSuchElementError]
        def find!
          return find_args.first if find_args.count >= 1 &&
                                    find_args.first.is_a?(::Selenium::WebDriver::Element)

          session.__getobj__.find_element(*find_args)
        end

        # @param session_wait_args [Array] Arguments for +Aranha::Selenium::Session::Wait.wait+.
        # @return [self]
        def wait_click(*session_wait_args)
          session.wait(*session_wait_args).until do
            find.if_present(nil) { |v| element_click(v) }
          end
          self
        end

        protected

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
end
