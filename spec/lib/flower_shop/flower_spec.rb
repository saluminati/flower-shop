# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe FlowerShop::Flower do
  let(:flower) { described_class.new(kind: 'Rose', product_code: 'A80', category: 'Catalina') }

  it { expect(flower.kind).to eq('Rose') }
  it { expect(flower.product_code).to eq('A80') }
  it { expect(flower.category).to eq('Catalina') }

  describe '#add_bundle' do
    it 'Adds to bundles' do
      expect(flower.bundles.size).to eq(0)
      flower.add_bundle(size: 5, cost: 20)
      expect(flower.bundles.size).to eq(1)
    end
  end
end
