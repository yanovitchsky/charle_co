require 'spec_helper'

RSpec.describe Operations::CalculateRental do
  subject(:context) { described_class.call(params: params, cars: cars) }

  let(:cars) do
    [{id: 1, car: Entities::Car.new(price_per_day: 2000, price_per_km: 10)}]
  end

  context 'with bad rental period' do
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

    it { expect(context).to be_a_failure }
    it { expect(context.error).to eq 'start_date is after end_date'}
  end

  context 'with unfound car' do
    let(:params) do
      { 
        cars: [
          { id: 1, price_per_day: 2000, price_per_km: 10 }
        ],
        rentals: [
          { id: 1, car_id: 2, start_date: "2017-12-8", end_date: "2017-12-9", distance: 100 }
        ]
      }
    end

    it { expect(context).to be_a_failure }
    it { expect(context.error).to eq 'car not found'}
  end

  context 'with correct inputs' do
    let(:params) do
      { 
        cars: [
          { id: 1, price_per_day: 2000, price_per_km: 10 }
        ],
        rentals: [
          { id: 1, car_id: 1, start_date: "2017-12-8", end_date: "2017-12-8", distance: 100 }
        ]
      }
    end

    let(:expected_result) do
      [
        { 
          id: 1,
          duration: 1,
          price: 3000
        }
      ]
    end
  
    it { expect(context.rentals).to eq expected_result}
  end
end