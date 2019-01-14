require 'oystercard'

RSpec.describe Oystercard do

  it "should return an Integer as balance" do
    expect(subject.balance).to be_kind_of(Integer)
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

  it "Should be an Integer" do
    expect(subject.new_balance(10)).to be_kind_of Integer
  end
end
