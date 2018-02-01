require 'spec_helper'

RSpec.describe RocketMapsGyms do
  before :each do
    ENV['ROCKET_MAPS'] = 'http:localhost:5000'
  end

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

  describe '.target' do
    subject { described_class }

    let(:raw_data) do
      File.open('./spec/fixtures/raw_data.json', 'r').read
    end

    let(:gyms) do
      [
        'The Charmbury Arms',
        'Marlborough Tavern',
        'The Bath Priory',
        'Lower Weston Post Office',
        'St. Michael And All Angels',
        'Oldfield Park Train Station'
      ]
    end

    it 'takes a players name' do
      expect {
        subject.target('SomePlayer')
      }.to raise_error(ArgumentError)
    end

    it 'returns a list of gyms the player is in' do
      allow(RocketMapsApi)
        .to receive(:raw_data_request)
        .and_return(raw_data)

      expect(subject.target(player_name: 'tiimotiimo').collect { |gym| gym[:name].strip }).to eql(gyms)
    end
  end

  describe '.stats' do
    subject { described_class }

    let(:raw_data) do
      File.open('./spec/fixtures/raw_data.json', 'r').read
    end

    let(:expected) do
      {
        mystic: 26,
        valor: 21,
        instinct: 14,
        uncontested: 0,
      }
    end

    it 'returns the number of gyms per team' do
      allow(RocketMapsApi)
        .to receive(:raw_data_request)
        .and_return(raw_data)

      expect(subject.gyms_per_team).to eql(expected)
    end
  end
end
