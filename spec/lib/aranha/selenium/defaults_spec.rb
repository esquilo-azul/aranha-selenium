# frozen_string_literal: true

require 'aranha/selenium/defaults'

::RSpec.describe ::Aranha::Selenium::Defaults do
  let(:instance) { described_class.instance }

  describe '#headless' do
    it { expect(instance.headless).to be(false) }

    context 'when user value is set' do
      before do
        instance.headless = 'true'
      end

      it { expect(instance.headless).to be(true) }
    end

    context 'when environment variable is set to false' do
      before do
        ENV['ARANHA_SELENIUM_HEADLESS'] = 'false'
      end

      it { expect(instance.headless).to be(false) }
    end

    context 'when environment variable is set to true' do
      before do
        ENV['ARANHA_SELENIUM_HEADLESS'] = 'true'
      end

      it { expect(instance.headless).to be(true) }
    end
  end
end
