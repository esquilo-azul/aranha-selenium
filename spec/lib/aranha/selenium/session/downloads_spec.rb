# frozen_string_literal: true

require 'aranha/selenium/session/downloads'

RSpec.describe Aranha::Selenium::Session::Downloads do
  let(:instance) { described_class.new }
  let(:file_path) { instance.dir.join('stub_file') }

  it do
    expect(instance.current).not_to include(file_path)
  end

  context 'when a closed file is added' do
    before do
      File.write(file_path, 'Any content')
    end

    it do
      expect(instance.current).to include(file_path)
    end

    context 'when a the files is open' do
      around do |example|
        File.open(file_path, 'w') do
          example.run
        end
      end

      it do
        expect(instance.current).not_to include(file_path)
      end
    end
  end
end
