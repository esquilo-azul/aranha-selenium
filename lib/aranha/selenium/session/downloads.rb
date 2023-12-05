# frozen_string_literal: true

require 'tmpdir'

module Aranha
  module Selenium
    class Session < ::SimpleDelegator
      class Downloads
        def current
          Dir.glob("#{dir}/**/*")
        end

        # @return [String]
        def dir
          @dir ||= ::Dir.mktmpdir
        end
      end
    end
  end
end
