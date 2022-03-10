# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe FlowerShop::Bundle do
  let(:bundle) { described_class.new(size: 5, cost: 20) }

  it { expect(bundle.size).to eq(5) }
  it { expect(bundle.cost).to eq(20) }
end
