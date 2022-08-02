module Calculators
  class Options
    def initialize(duration, price)
      @duration = duration
      @price = price
    end

    def calculate
      @price * @duration
    end
  end
end