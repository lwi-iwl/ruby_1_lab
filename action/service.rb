require 'date'
require_relative '../dao/file_reader'
require_relative '../models/train'

class Service
    def initialize
        @time_regex = /([0-1][0-9]|[2][0-3]):[0-5][0-9]/
        @file_reader = FileReader.new("trains.txt")
        @trains = init_all_trains
        @routes = Array.new
    end

    def init_all_trains
        trains = Array.new
        strings = @file_reader.get_all
        strings.each do |string|
            trains.push(get_new_train_by_string(string))
        end
        trains
    end

    def get_new_train_by_string(string)
        params = string.split
        get_new_train_by_params(number: params[0], departure_point: params[1], destination: params[2], departure_time: params[3], arrival_time: params[4], price: params[5])
    end

    def get_new_train_by_params(params)
        if @time_regex.match(params[:departure_time]) && @time_regex.match(params[:arrival_time])
            departure_time = DateTime.strptime(params[:departure_time], "%H:%M")
            arrival_time = DateTime.strptime(params[:arrival_time], "%H:%M")
        else
            departure_time = 0
            arrival_time = 0
        end
        Train.new(params[:number], departure_point: params[:departure_point], destination: params[:destination], departure_time: departure_time, arrival_time: arrival_time, price: params[:price])
    end

    def get_all_trains
        @trains
    end

    def get_train(index)
        @trains[index]
    end

    def del_train(index)
        @trains.delete_at(index)
    end

    def add(params)
        @trains.push(get_new_train_by_params(params))
    end

    def get_trains_by_time(departure_time_s, arrival_time_s)
        trains_by_time = nil
        if @time_regex.match(departure_time_s) && @time_regex.match(arrival_time_s)
            departure_time = DateTime.strptime(departure_time_s, "%H:%M")
            arrival_time = DateTime.strptime(arrival_time_s, "%H:%M")
            trains_by_time = @trains.find_all{|train| train.departure_time == departure_time && train.arrival_time == arrival_time}
        end
        trains_by_time
    end

    def get_trains_by_point(departure_point, destination)
        @trains.find_all{|train| train.departure_point == departure_point && train.destination == destination}
    end

    def navigate (departure_point, destination)
        @routes.clear
        departure_trains = @trains.find_all {|train| train.departure_point == departure_point}
        route = Array.new
        to_next(departure_trains, destination, route, DateTime.strptime("00:00", "%H:%M"))
        @routes
    end

    def to_next(departure_trains, destination, route, arrival_time)
        departure_trains.each do |departure_train|
            unless route.find_all { |past_city| past_city == departure_train.destination}.length && arrival_time > departure_train.departure_time
                route.push(departure_train)
                if departure_train.destination != destination
                    to_next(@trains.find_all {|train| train.departure_point == departure_train.destination}, destination, route, departure_train.arrival_time)
                else
                    route_string = ""
                    route.each { |train| route_string = route_string + train.number + " -> "}
                    @routes.push(route_string + "destination")
                    route.pop
                end
            end
        end
        route.pop
    end


end
        