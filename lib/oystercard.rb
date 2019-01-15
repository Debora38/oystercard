class Oystercard

  attr_accessor :balance
  attr_reader :entry_station
  MINIMUM_FARE = 1
  MAXIMUM_BALANCE = 90

  def initialize(balance = 0)
    @balance = balance
    @entry_station
  end

  def top_up(amount)
    raise "Maximum is #{Oystercard::MAXIMUM_BALANCE}, DENIED" if new_balance(amount) > MAXIMUM_BALANCE
    new_balance(amount)
  end

  def new_balance(amount)
    @balance += amount
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def enough_money?
    @balance < MINIMUM_FARE
  end

  def touch_in(location)
    raise ("Insufficient balance!") if enough_money?
    @in_journey = true
  end

 private

  def deduct(amount)
    @balance -= amount
  end
end
