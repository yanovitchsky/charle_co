module Operations
  class AddCommissions
    include Interactor

    def call
      context.rentals = context.rentals.map do |rental|
        duration = rental[:duration]
        amount = rental[:price]
        commission = calculate_commission(amount, duration)
        rental.slice(:id, :price).merge(commission: commission, duration: duration)
      end
    end

    private

    def calculate_commission(amount, duration)
      Calculators::BasicCommission.new(amount, duration).calculate
    end
  end
end