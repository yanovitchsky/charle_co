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
        duration = Helper.duration(attrs[:start_date], attrs[:end_date])
        price = price_for_rental(car, {duration: duration, distance: attrs[:distance]}).to_i
        commission = calculate_commission(price, duration)
        {
          id: attrs[:id],
          price: price,
          commission: commission
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

    def calculate_commission(amount, duration)
      Calculators::BasicCommission.new(amount, duration).calculate
    end
  end
end