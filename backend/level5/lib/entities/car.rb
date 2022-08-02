require 'chronic'
module Entities
  class Car
    def initialize(price_per_day:, price_per_km:, discounter: Discounts::BasicDiscount)
      @price_per_day = price_per_day
      @price_per_km = price_per_km
      @discounter = discounter
    end

    def rental_amount(duration:, distance:)
      amount(duration, distance)
    end


    private

    def periods(duration)
      hash = {}
      [10,4,1,0].inject(duration) do |durat, period| 
        res = durat - period; 
        hash[period] = (res < 0 ? 0 : res)
        res < 0 ? durat : durat - res
      end
      hash
    end

    def discounted_price_per_day(period)
      res = @discounter.new(@price_per_day, period).apply
      @price_per_day - res
    end

    def amount(duration, distance)
      period_prices = periods(duration).map do |period, dur|
        price_per_day = discounted_price_per_day(period)
        dur * price_per_day
      end

      period_prices.sum + (distance  * @price_per_km)
    end
  end
end