require 'station'

RSpec.describe Station do

  describe "#name" do
    let(:kingscross) { described_class.new('London Kings Cross', 1) }

    it "should respond to #name" do
      expect(kingscross).to respond_to :name
    end

    it "should pass a name to the instance variable" do
      wood_green = described_class.new('Wood Green', 3)
      expect(wood_green.name).not_to be_empty
    end
  end

  describe "#zone" do
    let(:kingscross) { described_class.new('London Kings Cross', 1) }

    it "should respond to zone" do
      expect(kingscross).to respond_to :zone
    end

    it "should pass a name to the instance variable" do
      wood_green = described_class.new('Wood Green', 3)
      expect(wood_green.zone).to eq 3
    end
  end
end
