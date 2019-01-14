require 'oystercard'

RSpec.describe Oystercard do

it "should return an Integer as balance" do
  expect(subject.balance).to be_kind_of(Integer)
end

end
