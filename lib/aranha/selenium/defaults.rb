# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'tmpdir'

module Aranha
  module Selenium
    class Defaults
      include ::Singleton

      DEFAULT_DOWNLOADS_DIR = ::File.join(::Dir.tmpdir, 'aranha_downloads_dir')
      DEFAULT_ACCEPT_INSECURE_CERTS = false
      DEFAULT_HEADLESS = false
      DEFAULT_USER_AGENT = nil

      attr_writer :accept_insecure_certs, :downloads_dir, :headless,
                  :user_agent

      def downloads_dir
        @downloads_dir || DEFAULT_DOWNLOADS_DIR
      end

      def accept_insecure_certs
        @accept_insecure_certs || DEFAULT_ACCEPT_INSECURE_CERTS
      end

      def headless
        @headless || DEFAULT_HEADLESS
      end

      def user_agent
        @user_agent || DEFAULT_USER_AGENT
      end
    end
  end
end
