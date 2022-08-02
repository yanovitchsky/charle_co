require 'spec_helper'

RSpec.describe Presenters::Action do
  subject { described_class.new(input).present }

  let(:input) do
    { 
      id: 1,
      price: 6600,
      options: [
        {
          id:1,
          rental_id: 1, 
          type: "gps"
        }
      ],
      commission: {
        total: 1980,
        owner_fee: 4620,
        insurance_fee: 990,
        assistance_fee: 300,
        drivy_fee: 690
      }
    }
  end

  let(:expected_result) do
    { 
      id: 1,
      options: ['gps'],
      actions: [
        {
          who: "driver",
          type: "debit",
          amount: 6600
        },
        {
          who: "owner",
          type: "credit",
          amount: 4620
        },
        {
          who: "insurance",
          type: "credit",
          amount: 990
        },
        {
          who: "assistance",
          type: "credit",
          amount: 300
        },
        {
          who: "drivy",
          type: "credit",
          amount: 690
        }
      ]
    }
  end

  it { is_expected.to eq expected_result }
end