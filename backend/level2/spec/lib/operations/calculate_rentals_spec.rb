require 'spec_helper'

RSpec.describe Operations::CalculateRentals do
  subject { Operations::CalculateRentals.new(context).call }

  context 'when there is a bad date in input' do
    let(:context) do
      { 
        cars: [
          { id: 1, price_per_day: 2000, price_per_km: 10 }
        ],
        rentals: [
          { id: 1, car_id: 1, start_date: "2017-12-8", end_date: "2017-12-7", distance: 100 }
        ]
      }
    end

    let(:expected_result) do
      { errors: 'start_date is after end_date'}
    end

    it { is_expected.to eq expected_result }
  end

  context 'when car not found' do
    let(:context) do
      { 
        cars: [
          { id: 1, price_per_day: 2000, price_per_km: 10 }
        ],
        rentals: [
          { id: 1, car_id: 2, start_date: "2017-12-8", end_date: "2017-12-7", distance: 100 }
        ]
      }
    end

    let(:expected_result) do
      { errors: 'car not found'}
    end

    it { is_expected.to eq expected_result }
  end

  context 'with correct inputs' do
    let(:context) do
      { 
        cars: [
          { id: 1, price_per_day: 2000, price_per_km: 10 }
        ],
        rentals: [
          { id: 1, car_id: 1, start_date: "2015-12-8", end_date: "2015-12-8", distance: 100 },
          { id: 2, car_id: 1, start_date: "2015-03-31", end_date: "2015-04-01", distance: 300 },
          { id: 3, car_id: 1, start_date: "2015-07-3", end_date: "2015-07-14", distance: 1000 }
        ]
      }
    end

    let(:expected_result) do
      { 
        rentals: [
          {
            id: 1,
            price: 3000
          },
          {
            id: 2,
            price: 6800
          },
          {
            id: 3,
            price: 27800
          }
        ]
      }
    end

    it { is_expected.to eq expected_result }
  end
end