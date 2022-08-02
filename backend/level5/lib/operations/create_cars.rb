module Operations
  class CreateCars
    include Interactor

    def call
      params = context.params
      context.cars = cars(params[:cars])
    end

    private

    def cars(cars_attrs)
      cars_attrs.map do |attrs|
        {
          id: attrs[:id], 
          car: Entities::Car.new(
            price_per_day: attrs[:price_per_day],
            price_per_km: attrs[:price_per_km])
        }
      end
    end
  end
end