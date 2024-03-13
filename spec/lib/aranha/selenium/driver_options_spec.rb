# frozen_string_literal: true

require 'aranha/selenium/driver_options'

RSpec.describe Aranha::Selenium::DriverOptions do
  let(:instance) { described_class.default }

  describe '#merge' do
    let(:instance) { described_class.new(headless: true, user_agent: 'ABC') }
    let(:other) { described_class.new(headless: false) }
    let(:result) do
      described_class.new(headless: false, user_agent: 'ABC')
    end

    it do
      expect(instance.merge(other.to_h)).to eq(result.to_h)
    end
  end

  describe '#to_h' do
    let(:instance) { described_class.new(headless: true, user_agent: 'ABC') }

    it do
      expect(instance.to_h).to eq(headless: true, user_agent: 'ABC')
    end
  end
end
