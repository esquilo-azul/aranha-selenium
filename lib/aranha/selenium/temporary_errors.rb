# frozen_string_literal: true

require 'selenium-webdriver'

module Aranha
  module Selenium
    module TemporaryErrors
      ALL_ERRORS = [::Selenium::WebDriver::Error::TimeoutError].freeze

      class << self
        def errors
          ALL_ERRORS
        end
      end
    end
  end
end
