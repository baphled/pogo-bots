require 'spec_helper'

RSpec.describe PogoWeather::Finder do
  describe '.find' do
    subject { described_class }

    context 'when there is clear' do
      it 'includes grass types' do
        expect(subject.find('Clear')[:types]).to include('grass')
      end

      it 'includes fire types' do
        expect(subject.find('Clear')[:types]).to include('fire')
      end

      it 'includes ground types' do
        expect(subject.find('Clear')[:types]).to include('ground')
      end
    end

    context 'when there is rain' do
      it 'includes water types' do
        expect(subject.find('Rain')[:types]).to include('water')
      end

      it 'includes electric types' do
        expect(subject.find('Rain')[:types]).to include('electric')
      end

      it 'includes bug types' do
        expect(subject.find('Rain')[:types]).to include('bug')
      end
    end

    context 'when there is snow' do
      it 'includes ice types' do
        expect(subject.find('Snow, accumulating 1-2 in')[:types]).to include('ice')
      end

      it 'includes steel types' do
        expect(subject.find('Snow, accumulating 1-2 in')[:types]).to include('steel')
      end
    end

    context 'when there is wind' do
      it 'includes psychic types' do
        expect(subject.find('Mainly cloudy and breezy')[:types]).to include('psychic')
      end
      it 'includes flying types' do
        expect(subject.find('Mainly cloudy and breezy')[:types]).to include('flying')
      end

      it 'includes dragon types' do
        expect(subject.find('Mainly cloudy and breezy')[:types]).to include('dragon')
      end
    end

    context 'when there is partly cloudy' do
      it 'includes normal types' do
        expect(subject.find('Partly cloudy')[:types]).to include('normal')
      end

      it 'includes rock types' do
        expect(subject.find('Partly cloudy')[:types]).to include('rock')
      end
    end

    context 'when it is overcast' do
      it 'includes poison types' do
        expect(subject.find('Overcast with a bit of ice')[:types]).to include('poison')
      end

      it 'includes fighting types' do
        expect(subject.find('Overcast with a bit of ice')[:types]).to include('fighting')
      end

      it 'includes fairy types' do
        expect(subject.find('Overcast with a bit of ice')[:types]).to include('fairy')
      end
    end

    context 'when there is fog' do
      it 'includes ghost types' do
        expect(subject.find('Low clouds and fog')[:types]).to include('ghost')
      end

      it 'includes dark types' do
        expect(subject.find('Low clouds and fog')[:types]).to include('dark')
      end
    end

    context 'when there is wind' do
      it 'includes psychic types' do
        expect(subject.find('Low clouds and fog')[:types]).to include('psychic')
      end

      it 'includes flying types' do
        expect(subject.find('Low clouds and fog')[:types]).to include('flying')
      end

      it 'includes dragon types' do
        expect(subject.find('Low clouds and fog')[:types]).to include('dragon')
      end
    end

    context 'when there is partly cloudy' do
      it 'includes normal types' do
        expect(subject.find('Partly cloudy')[:types]).to include('normal')
      end

      it 'includes rock types' do
        expect(subject.find('Partly cloudy')[:types]).to include('rock')
      end
    end

    context 'when it is overcast' do
      it 'includes poison types'
      it 'includes fighting types'
      it 'includes fairy types'
    end

    context 'when there is fog' do
      it 'includes ghost types' do
        expect(subject.find('Low clouds and fog')[:types]).to include('ghost')
      end

      it 'includes dark types' do
        expect(subject.find('Low clouds and fog')[:types]).to include('dark')
      end
    end
  end
end
