require_relative 'journey'

class Oystercard

  attr_accessor :balance
  attr_reader :journey
  
  MINIMUM_FARE = 1
  MAXIMUM_BALANCE = 90

  def initialize(balance = 0)
    @balance = balance
    @journey = Journey.new
  end

  def top_up(amount)
    raise "Maximum is #{Oystercard::MAXIMUM_BALANCE}, DENIED" if new_balance(amount) > MAXIMUM_BALANCE
    new_balance(amount)
  end

  def new_balance(amount)
    @balance += amount
  end

  def touch_out(location)
    deduct(MINIMUM_FARE)
    @journey.log_exit(location)
    # if journeys.last[:exit] == nil then = location & MIN FARE
    # else PENALTY
  end

  def enough_money?
    @balance < MINIMUM_FARE
  end

  def touch_in(location)
    raise ("Insufficient balance!") if enough_money?
    @journey.log_entry(location)
    # if journeys.last[:exit] != nil then location
    # else PENALTY
  end

 private

  def deduct(amount)
    @balance -= amount
  end
end
