# frozen_string_literal: true

require 'eac_templates/core_ext'

module Aranha
  module Selenium
    class Session < ::SimpleDelegator
      class FormRequest
        acts_as_instance_method
        common_constructor :session, :path, :verb, :fields do
          self.fields = ::Aranha::Selenium::Session::FormRequest::Field.assert_all(fields)
        end

        def result
          session.execute_script(script.pretty_debug)
        end

        private

        # @return [String]
        def script
          template.child('form_request_function.js').apply(script_args: script_args)
        end

        # @return [String]
        def script_args
          ["'#{path}'", "'#{verb}'", script_fields_arg].join(', ')
        end

        # @return [String]
        def script_fields_arg
          "{#{fields.map(&:to_js_object).join(', ')}}"
        end

        require_sub __FILE__
      end
    end
  end
end
