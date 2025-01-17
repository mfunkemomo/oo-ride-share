require_relative 'csv_record'

module RideShare
  class Passenger < CsvRecord
    attr_reader :name, :phone_number, :trips

    def initialize(id:, name:, phone_number:, trips: nil)
      super(id)

      @name = name
      @phone_number = phone_number
      @trips = trips || []
    end

    def add_trip(trip)
      @trips << trip
    end

    def net_expenditures
      array_of_cost = []
      @trips.each do |trip|
        array_of_cost << trip.cost
      end  
      net_exp = array_of_cost.sum 
      return net_exp
    end

    def total_time_spent
      array_of_time = []
      @trips.each do |trip|
        duration = trip.end_time - trip.start_time
        array_of_time << duration
      end  
      total_time = array_of_time.sum 
      return total_time
    end

    private

    def self.from_csv(record)
      return new(
        id: record[:id],
        name: record[:name],
        phone_number: record[:phone_num]
      )
    end
  end
end
