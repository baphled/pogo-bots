require 'spec_helper'

RSpec.describe TeamVerification::Processor do
  let(:uri) { './spec/fixtures/images/baphled-mystic.png' }
  let(:image_processor) { MiniMagick::Image }
  let(:width_of_image) { 640 }

  subject { described_class.new(uri: uri, image_processor: image_processor) }

  it 'has a uri' do
    expect(subject.uri).to eql(uri)
  end

  it 'has an image processor' do
    expect(subject.image_processor).to eql(image_processor)
  end

  it 'has an image' do
    expect(subject.image).to be_an(MiniMagick::Image)
  end

  it 'has an image array' do
    expect(subject.colour_array).to be_an(Array)
  end

  it 'has a pixel width' do
    expect(subject.pixel_width).to eql(width_of_image)
  end

  describe '#new' do
    subject { described_class }

    it 'takes an image uri' do
      expect{ subject.new }.to raise_error(ArgumentError)
    end

    context 'invalid image' do
      let(:uri) { './spec/fixtures/images/dot.tif' }

      it 'must be at least 640 pixels wide' do
        expect {
          subject.new(uri: uri, image_processor: image_processor)
        }.to raise_error(TeamVerification::InvalidPlayerImage)
      end
    end

    context 'smallest image possible' do
      let(:colour_array) { double(Array, count: width_of_image) }

      it 'does not raise an error' do
        allow_any_instance_of(TeamVerification::Processor)
          .to receive(:colour_array)
          .and_return(colour_array)

        expect {
          subject.new(uri: uri, image_processor: image_processor)
        }.to_not raise_error
      end
    end
  end
end
