# frozen_string_literal: true

require 'aranha/selenium/session/element'
require 'selenium-webdriver'

module Aranha
  module Selenium
    class Session < ::SimpleDelegator
      module Find
        # @return [Selenium::WebDriver::Element, nil]
        def find_element(*args, &block)
          return args.first if args.count >= 1 && args.first.is_a?(::Selenium::WebDriver::Element)

          __getobj__.find_element(*args, &block)
        end

        # @param find_element_args [Array] Argujments for +Selenium::WebDriver::Find.find_elements+.
        # @deprecated Use +{#element}.find+ instead.
        # @return [Selenium::WebDriver::Element, nil]
        def find_or_not_element(find_element_args)
          element(*find_element_args).find
        end
      end
    end
  end
end
