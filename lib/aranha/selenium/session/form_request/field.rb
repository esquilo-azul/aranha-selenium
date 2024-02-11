# frozen_string_literal: true

module Aranha
  module Selenium
    class Session < ::SimpleDelegator
      class FormRequest
        class Field
          class << self
            # @param source [Enumeration, Hash]
            # @return [Array<Aranha::Selenium::Session::FormRequest::Field>]
            def assert_all(source)
              if source.is_a?(::Hash)
                assert_all_from_hash(source)
              elsif source.is_a?(::Enumeration)
                assert_all_from_enumerable(source)
              else
                raise ::ArgumentError, "Invalid source type: #{source.class}"
              end
            end

            private

            def assert_all_from_enumerable(source)
              source.map { |e| new(*e) }
            end

            def assert_all_from_hash(source)
              source.map { |k, v| new(k, v) }
            end
          end

          common_constructor :name, :value

          # @return [String]
          def to_js_object
            "'#{name}': '#{value}'"
          end
        end
      end
    end
  end
end
