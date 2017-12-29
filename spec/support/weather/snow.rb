RSpec.shared_examples 'snow weather boost' do
  [
    'ice',
    'steel',
  ].each do |type|
    it "includes #{type} types" do
      expect(subject.find(weather_text)[:types]).to include(type)
    end
  end
end
