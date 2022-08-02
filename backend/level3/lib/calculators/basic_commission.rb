module Calculators
  class BasicCommission
    def initialize(amount, duration, commission=30)
      @duration = duration
      @fee = amount * commission / 100
    end

    def calculate
      { 
        insurance_fee: insurance.to_i,
        assistance_fee: assistance.to_i,
        drivy_fee: drivy.to_i,
      }
    end

    private

    def insurance
      @fee / 2
    end

    def assistance
      @duration * 100
    end

    def drivy
      @fee - insurance - assistance
    end
  end
end