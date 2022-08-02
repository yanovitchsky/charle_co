require 'spec_helper'

RSpec.describe Calculators::BasicCommission do
  subject { described_class.new(amount, duration).calculate }

  let(:amount)  { 1500 }
  let(:duration) { 1 }

  let(:expected_result) do
    {
      total_fee: 450,
      owner_fee: 1050,
      insurance_fee: 225,
      assistance_fee: 100,
      drivy_fee: 125,
    }
  end

  it { is_expected.to eq expected_result}

end