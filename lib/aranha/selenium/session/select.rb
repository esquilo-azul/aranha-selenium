# frozen_string_literal: true

module Aranha
  module Selenium
    class Session < ::SimpleDelegator
      module Select
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
      end
    end
  end
end
