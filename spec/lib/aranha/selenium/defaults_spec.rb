# frozen_string_literal: true

require 'aranha/selenium/defaults'

::RSpec.describe ::Aranha::Selenium::Defaults do
  let(:instance) { described_class.instance }

  describe '#headless' do
    it { expect(instance.headless).to eq(false) }

    context 'when user value is set' do
      before do
        instance.headless = 'true'
      end

      it { expect(instance.headless).to eq(true) }
    end
  end
end
