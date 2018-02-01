require 'spec_helper'

RSpec.describe RocketMapsGyms do
  describe '.names' do
    subject { described_class }

    let(:data) do
      {
        data: {
          'pokemon': false,
          'pokestops': false,
          'gyms': true,
          'scanned': false,
          'seen': false,
        }
      }
    end

    let(:raw_data) do
      File.open('./spec/fixtures/raw_data.json', 'r').read
    end

    let(:gym_names) do
      File.open('./spec/fixtures/gym_name_list.txt', 'r').readlines.collect(&:strip)
    end

    it 'returns a list of gyms' do
      allow(RocketMapsApi)
        .to receive(:raw_data_request)
        .and_return(raw_data)

      expect(subject.names).to eql(gym_names)
    end
  end
end
