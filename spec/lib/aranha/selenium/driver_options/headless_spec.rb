# frozen_string_literal: true

require 'aranha/selenium/driver_options'

RSpec.describe Aranha::Selenium::DriverOptions, '#headless' do
  let(:instance) { described_class.default }

  it { expect(instance.headless).to be(false) }

  [
    [true, nil, nil, true],
    [:yes, nil, nil, true],
    [:no, nil, nil, false],
    [nil, 'false', nil, false],
    [nil, 'true', nil, true],
    [nil, nil, nil, true],
    [nil, nil, ':0.0', false]
  ].each do |input|
    context "when input is #{input}" do
      let(:instance_value) { input[0] }
      let(:envvar_value) { input[1] }
      let(:auto_envvar_value) { input[2] }
      let(:expected_value) { input[3] }

      before do
        instance.headless = instance_value
        ENV['ARANHA_SELENIUM_HEADLESS'] = envvar_value
        ENV[Aranha::Selenium::DriverOptions::HEADLESS_AUTO_ENVVAR] = auto_envvar_value
      end

      it do
        expect(instance.headless).to be(expected_value)
      end
    end
  end
end
