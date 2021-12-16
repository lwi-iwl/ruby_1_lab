require_relative 'service'

class Core
  def initialize
    @service = Service.new
    start
  end

  def print
    puts @service.get_train(0).to_s
  end

  def start
    is_start = true
    while is_start
      puts "\n"
      puts "Get all trains: 0"
      puts "Get train by index: 1"
      puts "Get navigate: 2"
      puts "Add train: 3"
      puts "Delete train: 4"
      puts "Get all trains by time: 5"
      puts "Get all trains by point: 6"
      puts "Exit: 7"
      command = gets.chop
      case command
      when "0"
        get_all_trains
      when "1"
        get_train_by_index
      when "2"
        navigate
      when "3"
        add
      when "4"
        del
      when "5"
        get_trains_by_time
      when "6"
        get_trains_by_point
      when "7"
        is_start = false
      else
        puts "Enter valid command"
      end
      puts "\n"
    end
  end

  def get_all_trains
    trains = @service.get_all_trains
    index = 0
    trains.each do |train|
      puts index.to_s + ": " + train.to_s
      index+=1
    end
  end

  def get_train_by_index
    puts "Enter index"
    index = gets.chop.to_i
    puts @service.get_train(index)
  end

  def del
    puts "Enter index"
    index = gets.chop.to_i
    result = @service.del_train(index)
    if !result
      puts "The train does not exist"
    else
      puts "Delete: " + result.to_s
    end
  end

  def add
    puts "Enter number"
    number = gets.chop
    puts "Enter departure point"
    departure_point = gets.chop
    puts "Enter destination"
    destination = gets.chop
    puts "Enter departure time (HH:MM)"
    departure_time = gets.chop
    puts "Enter arrival time (HH:MM)"
    arrival_time = gets.chop
    puts "Enter price"
    price = gets.chop
    puts @service.add(number: number, departure_point: departure_point, destination: destination, departure_time: departure_time, arrival_time: arrival_time, price: price)
  end

  def get_trains_by_time
    puts "Enter departure time (HH:MM)"
    departure_time = gets.chop
    puts "Enter arrival time (HH:MM)"
    arrival_time = gets.chop
    trains = @service.get_trains_by_time(departure_time, arrival_time)
    if trains
      puts "Trains:"
      trains.each do |train|
        puts train.to_s
      end
      puts "\n"
    else
      puts "Non valid time"
    end
  end

  def get_trains_by_point
    puts "Enter departure point"
    departure_point = gets.chop
    puts "Enter destination"
    destination = gets.chop
    trains = @service.get_trains_by_point(departure_point, destination)
    puts "Trains:"
    trains.each do |train|
      puts train.to_s
    end
    puts "\n"
  end

  def navigate
    puts "Enter departure point"
    departure_point = gets.chop
    puts "Enter destination"
    destination = gets.chop
    routes = @service.navigate(departure_point, destination)
    puts routes.length
    routes.each do |route|
      puts route.to_s
    end
  end

end
