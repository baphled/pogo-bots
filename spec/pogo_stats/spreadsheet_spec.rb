require 'spec_helper'

RSpec.describe PogoStats::Spreadsheet do
  let(:values) do
    [
      ["Yomi", "baphled", "Mystic", "baphled", "14/07/2016", "20/06/2017", "40", "", "39,511,435", "252", "249", "", "56,363", "3,208.1", "7,235", "4,240", "46,199", "8,515", "3,255", "323", "380", "216", "15,502", "13,971", "171", "251", "8", "25", "23", "304", "16", "18"],
      [],
      ["ADD STATS BELOW THIS LINE:"]
    ]
  end

  subject { described_class.new(values: values) }

  it 'stores the original values' do
    expect(subject).to respond_to(:original_values)
  end

  it 'stores the parsed entries' do
    expect(subject).to respond_to(:entries)
  end

  describe '#new' do
    let(:expected_array) { values.first }

    subject { described_class }

    it 'takes an array of values' do
      expect { subject.new(values: values) }.not_to raise_error
    end

    it 'instantiates the a players general information' do
      expect(PogoStats::Stats::Player).to receive(:new).with(expected_array).exactly(:once)

      subject.new(values: values)
    end

    it 'instantiates the a players medal stats' do
      expect(PogoStats::Stats::Medals).to receive(:new).with(expected_array).exactly(:once)

      subject.new(values: values)
    end

    it 'instantiates the a players overall stats' do
      expect(PogoStats::Stats::Overall).to receive(:new).with(expected_array).exactly(:once)

      subject.new(values: values)
    end
  end

  describe '#entries' do
    let(:expected_leading_space) { [] }
    let(:expected_delimiter) { ["ADD STATS BELOW THIS LINE:"] }

    it 'includes player stats' do
      expect(subject.entries.first[:player]).to be_a(PogoStats::Stats::Player)
    end

    it 'includes player medals' do
      expect(subject.entries.first[:medals]).to be_a(PogoStats::Stats::Medals)
    end

    it 'includes player overall stats' do
      expect(subject.entries.first[:overall]).to be_a(PogoStats::Stats::Overall)
    end
  end
end
