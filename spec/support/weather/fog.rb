RSpec.shared_examples 'fog weather boost' do
  [
    'ghost',
    'dark',
  ].each do |type|
    it "includes #{type} types" do
      expect(subject.find(weather_text)[:types]).to include(type)
    end
  end
end

