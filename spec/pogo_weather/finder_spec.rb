require 'spec_helper'

RSpec.describe PogoWeather::Finder do
  describe '.find' do
    subject { described_class }

    it 'includes the clear weather pokemon' do
      expect(subject.find('clear')[:types]).to eql(
        [
          'grass',
          'fire',
          'ground',
        ]
      )
    end

    describe 'clear weather responses' do
      it_behaves_like 'clear weather boost' do
        let(:weather_text) { 'clear' }
      end

      it_behaves_like 'clear weather boost' do
        let(:weather_text) { 'sunny' }
      end
    end

    it 'includes the rain pokemon' do
      expect(subject.find('rain')[:types]).to eql(
        [
          'water',
          'electric',
          'bug',
        ]
      )
    end

    describe 'rain weather responses' do
      it_behaves_like 'rain weather boost' do
        let(:weather_text) { 'rain' }
      end

      it_behaves_like 'rain weather boost' do
        let(:weather_text) { 'shower' }
      end
    end

    it 'includes the snow pokemon' do
      expect(subject.find('snow')[:types]).to eql(
        [
          'ice',
          'steel'
        ]
      )
    end

    describe 'snow weather responses' do
      it_behaves_like 'snow weather boost' do
        let(:weather_text) { 'Snow' }
      end

      it_behaves_like 'snow weather boost' do
        let(:weather_text) { 'Snow, accumulating 1-2 in' }
      end
    end

    it 'includes the wind pokemon' do
      expect(subject.find('breezy')[:types]).to eql(
        [
          'psychic',
          'flying',
          'dragon',
        ]
      )
    end

    describe 'wind weather responses' do
      it_behaves_like 'wind weather boost' do
        let(:weather_text) { 'Mainly cloudy and breezy' }
      end

      it_behaves_like 'wind weather boost' do
        let(:weather_text) { 'breezy' }
      end
    end

    it 'includes the partly cloudy pokemon' do
      expect(subject.find('partly cloudy')[:types]).to eql(
        [
          'normal',
          'rock',
        ]
      )
    end

    describe 'partly cloudly weather responses' do
      it_behaves_like 'partly cloudy weather boost' do
        let(:weather_text) { 'Partly cloudy' }
      end

      it_behaves_like 'partly cloudy weather boost' do
        let(:weather_text) { 'mostly sunny' }
      end
    end

    it 'includes the overcast pokemon' do
      expect(subject.find('overcast')[:types]).to eql(
        [
          'poison',
          'fighting',
          'fairy',
        ]
      )
    end

    describe 'overcast weather responses' do
      it_behaves_like 'overcast weather boost' do
        let(:weather_text) { 'overcast' }
      end

      it_behaves_like 'overcast weather boost' do
        let(:weather_text) { 'cloudy' }
      end
    end

    it 'includes the fog pokemon' do
      expect(subject.find('fog')[:types]).to eql(
        [
          'ghost',
          'dark',
        ]
      )
    end

    describe 'fog weather responses' do
      it_behaves_like 'fog weather boost' do
        let(:weather_text) { 'fog' }
      end
    end
  end
end
