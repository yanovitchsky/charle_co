module Config
  OPTIONS = [
    { type: 'gps', price_per_day: 500, to: :owner_fee },
    { type: 'baby_seat', price_per_day: 200, to: :owner_fee },
    { type: 'additional_insurance', price_per_day: 1000, to: :drivy_fee }
  ]
end