require 'spec_helper'

RSpec.describe Entities::Car do
  subject do
    Entities::Car.new(price_per_day: 2000, price_per_km: 10)
      .rental_amount(duration: duration, distance: distance)
  end

  context 'with short rental period' do
    let(:duration) { 1 } 
    let(:distance) { 100 }

    it { is_expected.to eq(3000)}
  end

  context 'more than 1 day rental period' do
    let(:duration) { 4 } 
    let(:distance) { 100 }

    it { is_expected.to eq(8400)}
  end

  context 'more than 4 days rental period' do
    let(:duration) { 10 } 
    let(:distance) { 100 }

    it { is_expected.to eq(16800)}
  end

  context 'more than 10 days rental period' do
    let(:duration) { 11 } 
    let(:distance) { 100 }

    it { is_expected.to eq(17800)}
  end
end