require 'spec_helper'

RSpec.describe PoGoHelper do
  describe '.next_migration' do
    subject { described_class }

    let(:last_migration_hash) do
      { last_migration: '14/12/2017' }
    end

    it 'reads the last migration date' do
      expect(YAML)
        .to receive(:load_file)
        .and_return(last_migration_hash)

      subject.next_migration
    end

    it 'it returns the next migration date' do
      allow(YAML)
        .to receive(:load)
        .and_return(last_migration_hash)

      expect(subject.next_migration).to eql('28/12/2017')
    end

    context 'migration is today' do
      let(:last_migration) do
        Time.parse('28/12/2017')
      end

      let(:next_migration) do
        last_migration.to_date + 2.weeks
      end

      before(:each) do
        allow(YAML)
          .to receive(:load_file)
          .and_return(last_migration_hash)

        allow(Time)
          .to receive(:now)
          .and_return(last_migration)
      end

      it 'updates the last migration date' do
        allow(File)
          .to receive(:open)
          .and_return(true)

        expect(subject.next_migration).to eql(last_migration.strftime("%d/%m/%Y"))
      end

      it 'stores the latest migration date' do
        expect(File)
          .to receive(:open)
          .and_return(true)

        subject.next_migration
      end
    end
  end
end
