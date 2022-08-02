module Discounts
  class BasicDiscount
    def initialize(amount, period)
      @amount = amount
      @period = period
    end

    def apply
      case @period
      when 1
        @amount * 10 / 100
      when 4
        @amount * 30 / 100
      when 10
        @amount * 50 / 100
      else
        0
      end
    end
  end
end