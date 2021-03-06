require 'spec_helper'

RSpec.describe TeamColourMatrix::Models::RgbList do
  describe '#save' do
    subject { described_class.new }

    before(:each) do
      subject.valid?
    end

    it 'must have a R value' do
      expect(subject.errors.messages[:r]).to include("can't be blank")
    end

    it 'must have a G value' do
      expect(subject.errors.messages[:g]).to include("can't be blank")
    end

    it 'must have a B value' do
      expect(subject.errors.messages[:b]).to include("can't be blank")
    end

    it 'must have a team' do
      expect(subject.errors.messages[:team]).to include("can't be blank")
    end

    context 'RGB already saved for team' do
      subject { described_class.new(r: 0, g: 0, b:255, team: 'Mystic') }

      before(:each) do
        described_class.create(r: 0, g: 0, b:255, team: 'Mystic')
      end

      it 'must have a unique' do
        subject.valid?

        expect(subject.errors.messages[:team]).to eql(['has already been taken'])
      end
    end
  end


  describe '#team' do
    subject { described_class.new(r: 255, g: 0, b: 0) }

    it 'can be Valor' do
      subject.team = 'Valor'

      expect(subject).to be_valid
    end

    it 'can be Mystic' do
      subject.team = 'Mystic'

      expect(subject).to be_valid
    end

    it 'can be Instinct' do
      subject.team = 'Instinct'

      expect(subject).to be_valid
    end

    it 'can not be another value' do
      subject.team = 'foo'

      expect(subject).not_to be_valid
    end
  end
end
