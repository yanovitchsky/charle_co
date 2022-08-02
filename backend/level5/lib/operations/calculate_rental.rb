module Operations
  class CalculateRental
    include Interactor

    def call
      params = context.params
      context.rentals = params[:rentals].map do |rental|
        car = find_car(rental[:car_id])
        duration = rental_duration(rental[:start_date], rental[:end_date])
        {
          id: rental[:id],
          duration: duration,
          price: price(
            car,
            duration,
            rental[:distance]
          )
        }
      end
    rescue => e
      context.fail!(error: e.message)
    end

    private

    def find_car(id)
      car_infos = context.cars.find { |car| car[:id] == id }
      raise "car not found" unless car_infos
      car_infos[:car]
    end

    def rental_duration(start_date, end_date)
      Helper.duration(start_date, end_date)
    end

    def price(car, duration, distance)
      car.rental_amount(duration: duration, distance: distance)
    end
  end
end