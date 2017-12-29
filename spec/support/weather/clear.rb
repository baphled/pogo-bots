RSpec.shared_examples 'clear weather boost' do
  [
    'grass',
    'fire',
    'ground',
  ].each do |type|
    it "includes #{type} types" do
      expect(subject.find(weather_text)[:types]).to include(type)
    end
  end
end
