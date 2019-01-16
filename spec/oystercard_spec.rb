require 'oystercard'

RSpec.describe Oystercard do

  before do
    @entry_location = double("entry_location")
    @exit_location = double("exit_location")
  end

  context "@balance" do
    it "should return an Integer as balance" do
      expect(subject.balance).to be_kind_of(Integer)
    end
  end
    it "should respond to top_up method with 1 argument" do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it "should return an Integer" do
      expect(subject.top_up(5)).to be_kind_of Integer
    end

    it "should raise an error for maximum balance passed" do
      expect {subject.top_up(Oystercard::MAXIMUM_BALANCE + 1)}.to raise_error "Maximum is #{Oystercard::MAXIMUM_BALANCE}, DENIED"
    end

    it "should be an Integer" do
      expect(subject.new_balance(10)).to be_kind_of Integer
    end

  context "#in_journey?" do
    it "should return either true or false" do
      expect(subject.in_journey?).to eq(true).or eq(false)
    end
  end

  context "#touch_out" do
    it "returns false for in_journey?" do
      subject.instance_variable_set(:@in_journey, true)
      subject.instance_variable_set(:@balance, 5)
      subject.touch_in(@entry_location)
      subject.touch_out(@exit_location)
      expect(subject.in_journey?).to be_falsey
    end

    it "charges minimum fare" do
      subject.instance_variable_set(:@balance, 10)
      subject.touch_in(@entry_location)
      expect { subject.touch_out(@exit_location) }.to change { subject.balance }.by(-1)
    end

    it "should set location to nil" do
      subject.instance_variable_set(:@entry_station, @entry_location)
      subject.instance_variable_set(:@balance, 5)
      subject.touch_in(@entry_location)
      subject.touch_out(@exit_location)
      expect(subject.entry_station).to be_nil
    end

    it "should log exit_station in the array" do
      subject.instance_variable_set(:@balance, 5)
      subject.touch_in(@entry_location)
      subject.touch_out(@exit_location)
      expect(subject.journeys).to eq [{ entry: @entry_location, exit: @exit_location}]
    end
  end

  context "#touch_in" do
    it "should return true for in_journey?" do
      subject.instance_variable_set(:@entry_station, @entry_location)
      subject.instance_variable_set(:@balance, 5)
      expect(subject.in_journey?).to be_truthy
    end

    it "MINIMUM_FARE is £1" do
      expect(Oystercard::MINIMUM_FARE).to eq(1)
    end

    it "raises exception at touch in if balance < MINIMUM_FARE" do
      subject.instance_variable_set(:@balance,0)
      expect { subject.touch_in(@entry_location) }.to raise_error("Insufficient balance!")
    end

    it "should return a value for the entry_station variable" do
      subject.instance_variable_set(:@balance, 5)
      subject.touch_in(@entry_location)
      expect(subject.entry_station).not_to be_nil
    end

    it "should log entry_station in the array" do
      subject.instance_variable_set(:@balance, 5)
      @entry_location = double("entry_location")
      subject.touch_in(@entry_location)
      expect(subject.journeys).to eq [{ entry: @entry_location, exit: nil}]
    end
  end

  context "#entry_station" do
    it { is_expected.to respond_to(:entry_station)}
  end
end
