RSpec.shared_examples 'overcast weather boost' do
  [
    'poison',
    'fighting',
    'fairy',
  ].each do |type|
    it "includes #{type} types" do
      expect(subject.find(weather_text)[:types]).to include(type)
    end
  end
end
