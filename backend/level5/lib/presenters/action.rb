module Presenters
  class Action < Base
    def present
      {
        id: @object[:id],
        options: option_types,
        actions: [
          driver,
          owner,
          insurance,
          assistance,
          drivy
        ]
      }
    end

    private

    def option_types
      @object[:options].map{ |option| option[:type] }
    end

    def owner
      amount = @object[:commission][:owner_fee]
      {
        who: 'owner',
        type: 'credit',
        amount: amount
      }
    end

    def driver
      amount = @object[:price]
      {
        who: 'driver',
        type: 'debit',
        amount: amount
      }
    end

    def insurance
      amount = @object[:commission][:insurance_fee]
      {
        who: 'insurance',
        type: 'credit',
        amount: amount
      }
    end

    def assistance
      amount = @object[:commission][:assistance_fee]
      {
        who: 'assistance',
        type: 'credit',
        amount: amount
      }
    end

    def drivy
      amount = @object[:commission][:drivy_fee]
      {
        who: 'drivy',
        type: 'credit',
        amount: amount
      }
    end
  end
end