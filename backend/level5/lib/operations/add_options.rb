module Operations
  class AddOptions
    include Interactor

    def call
      context.rentals.each do |rental|
        rental_options = find_options(rental[:id])
        rental[:options] = rental_options
        apply_option_for_rental(rental, rental_options)
      end
    end

    private

    def options
      context.params[:options]
    end

    def find_options(rental_id)
      options.select do |option|
        option[:rental_id] == rental_id
      end
    end

    def apply_option_for_rental(rental, options)
      options.each do |option|
        type = option[:type]
        config = find_config_for(type)
        price_per_day = config[:price_per_day]
        commission_type = config[:to]
        option_cost = (price_per_day * rental[:duration])
        rental[:commission][commission_type] += option_cost
        rental[:price] += option_cost
      end
    end

    def find_config_for(type)
      Config::OPTIONS.find { |config| config[:type] == type }
    end
  end
end