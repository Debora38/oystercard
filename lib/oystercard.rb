class Oystercard

  attr_accessor :balance
  MINIMUM_FARE = 1
  MAXIMUM_BALANCE = 90

  def initialize(balance = 0, in_journey = false)
    @balance = balance
    @in_journey = in_journey
  end

  def top_up(amount)
    raise "Maximum is #{Oystercard::MAXIMUM_BALANCE}, DENIED" if new_balance(amount) > MAXIMUM_BALANCE
    new_balance(amount)
  end

  def new_balance(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_out
    @in_journey = false
  end

  def enough_money?
    @balance < MINIMUM_FARE
  end

  def touch_in
    raise ("Insufficient balance!") if enough_money?
    @in_journey = true
  end
end
