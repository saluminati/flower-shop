# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe FlowerShop::Bundle do
  let(:bundle) { described_class.new(size: 5, cost: 20) }

  it { expect(bundle.size).to eq(5) }
  it { expect(bundle.cost).to eq(20) }

  it 'raises exception on size less than or equal to 1' do
    expect do
      described_class.new(size: 1, cost: 20)
    end.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::BUNDLE_SIZE_ERROR)
  end
end
