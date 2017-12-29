RSpec.shared_examples 'rain weather boost' do
  [
    'water',
    'electric',
    'bug',
  ].each do |type|
    it "includes #{type} types" do
      expect(subject.find(weather_text)[:types]).to include(type)
    end
  end
end
