class Oystercard

  attr_reader :balance

  MAXIMUM_BALANCE = 90
  
  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    raise "Maximum is #{Oystercard::MAXIMUM_BALANCE}, DENIED" if new_balance(amount) > MAXIMUM_BALANCE
    new_balance(amount)
  end

  def new_balance(amount)
    @balance += amount
    return @balance
  end
end
