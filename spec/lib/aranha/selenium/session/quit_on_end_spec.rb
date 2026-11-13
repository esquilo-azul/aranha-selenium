# frozen_string_literal: true

RSpec.describe Aranha::Selenium::Session, '#quit_on_end' do
  let(:driver) { instance_double(Selenium::WebDriver::Driver, quit: nil) }
  let(:instance) { described_class.new }

  before do
    allow(Aranha::Selenium::DriverFactory).to receive(:create_driver).and_return(driver)
  end

  context 'when block succeeds' do
    let!(:result) { instance.quit_on_end { |session| [:result, session] } }

    it { expect(result).to eq([:result, instance]) }
    it { expect(driver).to have_received(:quit).once }
  end

  context 'when block raises' do
    before do
      instance.quit_on_end { raise 'failure' }
    rescue RuntimeError
      nil
    end

    it { expect(driver).to have_received(:quit).once }
  end
end
