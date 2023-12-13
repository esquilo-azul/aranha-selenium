# frozen_string_literal: true

require 'aranha/selenium/driver_options'

RSpec.describe Aranha::Selenium::DriverOptions do
  let(:instance) { described_class.default }

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

  describe '#to_h' do
    let(:instance) { described_class.new(headless: true, user_agent: 'ABC') }

    it do
      expect(instance.to_h).to eq(headless: true, user_agent: 'ABC')
    end
  end
end
