require 'spec_helper'

RSpec.describe Operations::AddCommissions do
  subject(:context) { described_class.call(params: params, rentals: rentals) }

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

  let(:rentals) do
    [
      { 
        id: 1,
        duration: 1,
        price: 3000
      }
    ]
  end

  let(:expected_result) do
    [
      { 
        id: 1,
        duration: 1,
        price: 3000,
        commission: {
          total_fee: 900,
          owner_fee: 2100,
          insurance_fee: 450,
          assistance_fee: 100,
          drivy_fee: 350
        }
      }
    ]
  end

  it { expect(context.rentals).to eq expected_result}
end