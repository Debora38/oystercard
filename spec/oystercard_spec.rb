require 'oystercard'

RSpec.describe Oystercard do
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

 context "#deduct" do
    it "should return an Integer" do
      subject.instance_variable_set(:@balance, 20)
      expect(subject.deduct(3)).to be_kind_of Integer
    end

    it "should return a new lower balance" do
      subject.instance_variable_set(:@balance, 20)
      expect(subject.deduct(3)).to eq 17
    end

    it "should return a new lower balance" do
      subject.top_up(20)
      expect { subject.deduct 3 }.to change{ subject.balance }.by -3
    end
 end
  context "#in_journey?" do
    it "should return either true or false" do
      expect(subject.in_journey?).to eq(true).or eq(false)
    end
  end

context "#touch_out" do
  it "sets in_journey to false" do
    subject.instance_variable_set(:@in_journey, true)
    subject.touch_out
    expect(subject.in_journey?).to be_falsey
  end

  it "charges minimum fare" do
    subject.instance_variable_set(:@balance, 10)
    expect { subject.touch_out }.to change { subject.balance }.by(-1)
  end
end

context "#touch_in" do
  it "sets in_journey to true" do
    subject.instance_variable_set(:@in_journey, false)
    subject.instance_variable_set(:@balance, 5)
    subject.touch_in
    expect(subject.in_journey?).to be_truthy
  end

  it "MINIMUM_FARE is £1" do
    expect(Oystercard::MINIMUM_FARE).to eq(1)
  end

  it "raises exception at touch in if balance < MINIMUM_FARE" do
    subject.instance_variable_set(:@balance,0)
    expect { subject.touch_in }.to raise_error("Insufficient balance!")
  end
end
end
