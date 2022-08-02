require 'chronic'
module Entities
  class Car
    def initialize(price_per_day:, price_per_km:, discounter: Discounts::BasicDiscount)
      @price_per_day = price_per_day
      @price_per_km = price_per_km
      @discounter = discounter
    end

    def rental_amount(start_date:, end_date:, distance:)
      rental_duration = duration(start_date, end_date)
      amount(rental_duration, distance)
    end


    private

    def duration(start_date, end_date)
      date_duration = (Chronic.parse(end_date) - Chronic.parse(start_date))
      raise Errors::Date.new("start_date is after end_date") if date_duration < 0
      date_duration / 3600 / 24 + 1
    end

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