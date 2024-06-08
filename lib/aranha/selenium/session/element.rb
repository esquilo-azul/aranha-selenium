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
      end
    end
  end
end
