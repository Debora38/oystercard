require 'journey'

RSpec.describe Journey do

  before do
    @station = double('station')
  end

  describe "#log_entry"
  it "should return an entry station" do
    expect(subject.log_entry(@station)).to be_kind_of Array
  end

  it "should return an entry station" do
    expect(subject.log_entry(@station).last[:entry]).to eq @station
  end

  it "should return an exit station" do
    subject.log_entry(@station)
    subject.log_exit(@station)
    expect(subject.journeys.last[:exit]).to eq @station
  end
end
