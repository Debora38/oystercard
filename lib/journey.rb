class Journey

  attr_reader :journeys

  def initialize
    @journeys = []
  end

  def log_entry(location)
    @journeys.push({ entry: location, exit: nil })
  end

  def log_exit(location)
    @journeys.last[:exit] = location
  end

  def special_log_exit(location)
    @journeys.push({ entry: nil, exit: location })
  end
end
