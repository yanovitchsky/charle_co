require 'spec_helper'

RSpec.describe Operations::CreateCars do
  subject(:context) { described_class.call(params: params)}

  let(:params) do
    { 
      cars: [
        { id: 1, price_per_day: 2000, price_per_km: 10 }
      ],
      rentals: [
        { id: 1, car_id: 1, start_date: "2017-12-8", end_date: "2017-12-7", distance: 100 }
      ]
    }
  end

  it 'creates a list of cars' do
    expect(context.cars.size).to eq 1
  end
end