require 'chronic'
module Helper
  def self.duration(start_date, end_date)
    date_duration = (Chronic.parse(end_date) - Chronic.parse(start_date))
    raise Errors::Date.new("start_date is after end_date") if date_duration < 0
    date_duration / 3600 / 24 + 1
  end
end