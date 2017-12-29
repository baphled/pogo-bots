RSpec.shared_examples 'wind weather boost' do
  [
    'psychic',
    'flying',
    'dragon',
  ].each do |type|
    it "includes #{type} types" do
      expect(subject.find(weather_text)[:types]).to include(type)
    end
  end
end
