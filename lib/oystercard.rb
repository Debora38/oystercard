require_relative 'journey'

class Oystercard

  attr_accessor :balance
  attr_reader :journey

  MINIMUM_FARE = 1
  MAXIMUM_BALANCE = 90
  PENALTY_FARE = 6

  def initialize(balance = 0, journey = Journey.new)
    @balance = balance
    @journey = journey
  end

  def top_up(amount)
    raise "Max is #{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE

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
    raise "Insufficient balance!" if enough_money?

    @journey.log_entry(location)

#    deduct(PENALTY_FARE) if @journey.journeys.last[:exit] == nil
  end

 private

  def deduct(amount)
    @balance -= amount
  end
end
