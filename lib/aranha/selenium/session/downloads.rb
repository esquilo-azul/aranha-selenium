# frozen_string_literal: true

require 'tmpdir'

module Aranha
  module Selenium
    class Session < ::SimpleDelegator
      class Downloads
        attr_reader :dir

        def initialize
          @dir = ::Dir.mktmpdir
        end

        def current
          Dir.glob("#{dir}/**/*")
        end
      end
    end
  end
end
