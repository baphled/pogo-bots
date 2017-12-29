RSpec.shared_examples 'partly cloudy weather boost' do
  [
    'normal',
    'rock',
  ].each do |type|
    it "includes #{type} types" do
      expect(subject.find(weather_text)[:types]).to include(type)
    end
  end
end
