# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Aranha
  module Selenium
    module Executables
      class << self
        enable_simple_cache

        def env
          ::EacRubyUtils::Envs.local
        end

        private

        %w[chromedriver geckodriver].each do |program|
          define_method("#{program.underscore}_uncached") do
            env.executable(program, '--version')
          end
        end
      end
    end
  end
end
