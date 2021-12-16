class Train
  attr_accessor :number, :departure_point, :destination, :departure_time, :arrival_time, :price

    def initialize(number, options)
      self.number = number
      self.departure_point = options[:departure_point]
      self.destination = options[:destination]
      self.departure_time = options[:departure_time]
      self.arrival_time = options[:arrival_time]
      self.price = options[:price]
    end

  def to_s
    number + " " + departure_point + " " + destination + " " + departure_time.strftime("%H:%M") + " " + arrival_time.strftime("%H:%M") + " " + price
  end
end