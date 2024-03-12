# frozen_string_literal: true

require 'aranha/selenium/session'

RSpec.describe Aranha::Selenium::Session do
  around do |example|
    StubWebServer.open do |server|
      @server = server
      server.wait
      example.run
    end
  end

  %i[firefox].each do |driver_name|
    context "when driver is #{driver_name}" do
      let(:session_options) { { driver: driver_name, headless: true } }
      let(:session) { described_class.new(session_options) }
      let(:actual_download_file) do
        session.wait_for_download do
          session.find_element(xpath: '//a[text() = "Download"]').click
        end
      end
      let(:expected_download_content) { StubWebServer.load_file('download.txt') }

      before do
        session.navigate.to @server.root_url # rubocop:disable RSpec/InstanceVariable
      end

      after do
        session.close
      end

      it 'finds a element' do
        expect(session.find_element(xpath: '//*[contains(text(), "World")]')).to be_present
      end

      it 'downloads a file' do
        expect(actual_download_file.read).to eq(expected_download_content)
      end
    end
  end
end
