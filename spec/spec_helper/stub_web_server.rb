# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'stub_server'

class StubWebServer < StubServer
  class << self
    # @param basename [String]
    # @return [String]
    def load_file(basename)
      __dir__.to_pathname.join(__FILE__.to_pathname.basename('.rb'), basename).read
    end
  end

  PORT = 3000
  REPLIES = {
    '/' => [200, {}, [load_file('root.html')]],
    '/download' => [200, {
      'Content-Disposition' => 'attachment; filename="download.txt"'
    }, [load_file('download.txt')]]
  }.freeze
  OPTIONS = {}.freeze

  def self.open(&block)
    super(PORT, REPLIES, OPTIONS, &block)
  end

  # @return [String]
  def root_url
    "http://127.0.0.1:#{@port}"
  end
end
