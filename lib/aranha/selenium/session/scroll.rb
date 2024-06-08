# frozen_string_literal: true

require 'selenium-webdriver'

module Aranha
  module Selenium
    class Session < ::SimpleDelegator
      module Scroll
        NULL_SCROLL = 0
        DEFAULT_SCROLL = 100

        # @param delta_x [Integer] Number of pixels.
        # @param delta_y [Integer] Number of pixels.
        # @return [self]
        def scroll_by(delta_x, delta_y)
          execute_script("window.scrollBy(#{delta_x.to_i}, #{delta_y.to_i})")

          self
        end

        # @param delta_x [Integer] Number of pixels.
        # @return [self]
        def scroll_left_by(delta_x = DEFAULT_SCROLL)
          scroll_right_by(-delta_x)
        end

        # @param delta_y [Integer] Number of pixels.
        # @return [self]
        def scroll_down_by(delta_y = DEFAULT_SCROLL)
          scroll_by(NULL_SCROLL, delta_y)
        end

        # @param delta_x [Integer] Number of pixels.
        # @return [self]
        def scroll_right_by(delta_x = DEFAULT_SCROLL)
          scroll_by(delta_x, NULL_SCROLL)
        end

        # @param delta_y [Integer] Number of pixels.
        # @return [self]
        def scroll_up_by(delta_y = DEFAULT_SCROLL)
          scroll_down_by(-delta_y)
        end
      end
    end
  end
end
