# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'tmpdir'

module Aranha
  module Selenium
    class Session < ::SimpleDelegator
      class Downloads
        def current
          Dir.glob("#{dir}/**/*")
        end

        # @return [Pathname]
        def dir
          @dir ||= ::Dir.mktmpdir.to_pathname
        end
      end
    end
  end
end
