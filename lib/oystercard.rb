class Oystercard

  attr_accessor :balance
  attr_reader :entry_station, :journeys
  MINIMUM_FARE = 1
  MAXIMUM_BALANCE = 90

  def initialize(balance = 0)
    @balance = balance
    @entry_station
    @journeys = []
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

  def touch_out(location)
    deduct(MINIMUM_FARE)
    @journeys.last[:exit] = location
    # if journeys.last[:exit] == nil then = location & MIN FARE
    # else PENALTY
    @entry_station = nil
  end

  def enough_money?
    @balance < MINIMUM_FARE
  end

  def touch_in(location)
    raise ("Insufficient balance!") if enough_money?
    @journeys.push({entry: location, exit: nil})
    # if journeys.last[:exit] != nil then location
    # else PENALTY
    @entry_station = location
  end

 private

  def deduct(amount)
    @balance -= amount
  end
end
