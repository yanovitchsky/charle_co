require 'chronic'
module Entities
  class Car
    def initialize(price_per_day:, price_per_km:)
      @price_per_day = price_per_day
      @price_per_km = price_per_km
    end

    def rental_amount(start_date:, end_date:, distance:)
      rental_duration = duration(start_date, end_date)
      duration(start_date, end_date) * @price_per_day + distance  * @price_per_km
    end


    private

    def duration(start_date, end_date)
      date_duration = (Chronic.parse(end_date) - Chronic.parse(start_date))
      raise Errors::Date.new("start_date is after end_date") if date_duration < 0
      date_duration / 3600 / 24 + 1
    end
  end
end