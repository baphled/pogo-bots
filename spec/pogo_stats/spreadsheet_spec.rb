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
    subject { described_class }

    it 'takes an array of values' do
      expect { subject.new(values: values) }.not_to raise_error
    end
  end

  describe '#entries' do
    it 'does not include empty lines' do
      expect(subject.entries).not_to include([])
    end

    it 'does not include the message line' do
      expect(subject.entries).not_to include(["ADD STATS BELOW THIS LINE:"])
    end
  end
end
