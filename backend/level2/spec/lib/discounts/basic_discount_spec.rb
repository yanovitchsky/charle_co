require 'spec_helper'

RSpec.describe Discounts::BasicDiscount do
  subject { Discounts::BasicDiscount.new(amount, period).apply }

  context 'when period is 1' do
    let(:amount) { 100 }
    let(:period) { 1 }

    it { is_expected.to eq 10 }
  end

  context 'when period is 4' do
    let(:amount) { 100 }
    let(:period) { 4 }

    it { is_expected.to eq 30 }
  end

  context 'when period is 10' do
    let(:amount) { 100 }
    let(:period) { 10 }

    it { is_expected.to eq 50 }
  end

  context 'when period is 0' do
    let(:amount) { 100 }
    let(:period) { 0 }

    it { is_expected.to eq 0 }
  end

  context 'when period is anything else' do
    let(:amount) { 100 }
    let(:period) { 22 }

    it { is_expected.to eq 0 }
  end
end