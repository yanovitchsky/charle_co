module Operations
  class CalculateRentals
    def initialize(context)
      @context = context
    end

    def call
      rentals
    end

    private

    def cars
      @cars ||= create_cars
    end

    def create_cars
      @context[:cars].map do |attrs|
        {
          id: attrs[:id], 
          car: Entities::Car.new(
            price_per_day: attrs[:price_per_day],
            price_per_km: attrs[:price_per_km])
        }
      end
    end

    def rentals
      result = @context[:rentals].map do |attrs|
        car = find_car(attrs[:car_id])
        {
          id: attrs[:id],
          price: price_for_rental(car, attrs.slice(:start_date, :end_date, :distance)).to_i
        }
      end
      { rentals: result }
    rescue => e
      { errors: e.message }
    end

    def price_for_rental(car, rental_infos)
      car.rental_amount(**rental_infos)
    end

    def find_car(id)
      car_infos = cars.find { |car| car[:id] == id }
      raise "car not found" unless car_infos
      car_infos[:car]
    end
  end
end