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

  it "should return the topped up amount" do
    expect(subject.top_up(5)).to eq 5
  end

  it "should raise an error for maximum balance passed" do
    expect { subject.top_up(Oystercard::MAXIMUM_BALANCE + 1) }.to raise_error "Max is #{Oystercard::MAXIMUM_BALANCE}"
  end

  it "should be an Integer" do
    expect(subject.new_balance(10)).to be_kind_of Integer
  end

  context "#touch_out" do
    it "charges minimum fare" do
      subject.instance_variable_set(:@balance, 10)
      subject.touch_in(@entry_location)
      expect { subject.touch_out(@exit_location) }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
    end

    it "should log exit_station in the array" do
      subject.instance_variable_set(:@balance, 5)
      subject.touch_in(@entry_location)
      subject.touch_out(@exit_location)
      expect(subject.journey.journeys).to eq [{ entry: @entry_location, exit: @exit_location }]
    end
  end

  context "#touch_in" do
    it "MINIMUM_FARE is £1" do
      expect(Oystercard::MINIMUM_FARE).to eq(1)
    end

    it "raises exception at touch in if balance < MINIMUM_FARE" do
      subject.instance_variable_set(:@balance, 0)
      expect { subject.touch_in(@entry_location) }.to raise_error("Insufficient balance!")
    end

    it "should log entry_station in the array" do
      subject.instance_variable_set(:@balance, 5)
      @entry_location = double("entry_location")
      subject.touch_in(@entry_location)
      expect(subject.journey.journeys).to eq [{ entry: @entry_location, exit: nil }]
    end
  end

  context "#fare" do
    describe "#touch_in" do
      it "double touch_in should charge penalty fare" do
        subject.instance_variable_set(:@balance, 10)
        subject.touch_in(@entry_location)
        expect { subject.touch_in(@entry_location) }.to change { subject.balance }.by(-Oystercard::PENALTY_FARE)
      end

      it "touch_in of a used card should not charge PENALTY_FARE if previous journey was touched out" do
        subject.instance_variable_set(:@balance, 10)
        subject.touch_in(@entry_location)
        subject.touch_out(@exit_location)
        expect { subject.touch_in(@entry_location) }.to change { subject.balance }.by(0)
      end

      it "first touch_in of a new card should not charge PENALTY_FARE" do
        subject.instance_variable_set(:@balance, 10)
        expect { subject.touch_in(@entry_location) }.to change { subject.balance }.by(0)
      end
    end
  end
end
