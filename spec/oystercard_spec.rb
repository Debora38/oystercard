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

end
