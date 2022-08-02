require 'spec_helper'

RSpec.describe Entities::Car do
  subject do
    Entities::Car.new(price_per_day: 2000, price_per_km: 10)
      .rental_amount(start_date: start_date, end_date: end_date, distance: distance)
  end

  context 'when start_date is after end_date' do
    let(:start_date) { '2017-12-8' } 
    let(:end_date) { '2017-12-7' } 
    let(:distance) { 100 } 
    it 'raise Error' do
      expect{subject}.to raise_error(Errors::Date, 'start_date is after end_date')
    end
  end

  context 'with short rental period' do
    let(:start_date) { '2017-12-8' } 
    let(:end_date) { '2017-12-8' } 
    let(:distance) { 100 }

    it { is_expected.to eq(3000)}
  end

  context 'more than 1 day rental period' do
    let(:start_date) { '2017-12-8' } 
    let(:end_date) { '2017-12-11' } 
    let(:distance) { 100 }

    it { is_expected.to eq(8400)}
  end

  context 'more than 4 days rental period' do
    let(:start_date) { '2017-12-8' } 
    let(:end_date) { '2017-12-17' } 
    let(:distance) { 100 }

    it { is_expected.to eq(16800)}
  end

  context 'more than 10 days rental period' do
    let(:start_date) { '2017-12-8' } 
    let(:end_date) { '2017-12-18' } 
    let(:distance) { 100 }

    it { is_expected.to eq(17800)}
  end
end