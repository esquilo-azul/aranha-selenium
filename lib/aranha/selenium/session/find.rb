# frozen_string_literal: true

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

        def find_or_not_element(find_element_args)
          r = find_elements(find_element_args)
          r.any? ? r.first : nil
        end
      end
    end
  end
end
