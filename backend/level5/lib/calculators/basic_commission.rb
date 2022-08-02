module Calculators
  class BasicCommission
    def initialize(amount, duration, commission=30)
      @amount = amount
      @duration = duration
      @commission = commission
    end

    def calculate
      { 
        total_fee: fee.to_i,
        owner_fee: owner.to_i,
        insurance_fee: insurance.to_i,
        assistance_fee: assistance.to_i,
        drivy_fee: drivy.to_i,
      }
    end

    private

    def owner
      @amount - fee
    end

    def insurance
      fee / 2
    end

    def assistance
      @duration * 100
    end

    def drivy
      fee - insurance - assistance
    end

    def fee
      @fee ||=  @amount * @commission / 100
    end
  end
end