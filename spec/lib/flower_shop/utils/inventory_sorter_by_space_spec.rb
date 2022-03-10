# frozen_string_literal: true

require_relative '../../spec_helper'

RSpec.describe FlowerShop::InventorySorterBySpace do
  context 'when order of flowers is 10 and available bundles size are [5,10]' do
    it 'selects one bundle of 10 instead of two bundles of 5' do
      bundles = []
      [5, 10].each { |i| bundles << FlowerShop::Bundle.new(size: i, cost: rand(i)) }
      bundles_order = described_class.new(quantity: 10, bundles: bundles).bundles_order
      expect(bundles_order.class).to eq(Array)
      expect(bundles_order.size).to eq(1)
      expect(bundles_order.first).to eq(10)
    end
  end

  context 'when flowers amount ordered is less than all available bundles' do
    it 'picks the closest possible bundle to the order' do
      bundles = []
      [3, 6, 9].each { |i| bundles << FlowerShop::Bundle.new(size: i, cost: rand(i)) }
      bundles_order = described_class.new(quantity: 2, bundles: bundles).bundles_order
      expect(bundles_order.class).to eq(Array)
      expect(bundles_order.size).to eq(1)
      expect(bundles_order.first).to eq(3)
    end
  end

  context 'when order of flowers is 15 and available bundles size are [3,6,9]' do
    it 'selects bundles of 9 and 6' do
      bundles = []
      [3, 6, 9].each { |i| bundles << FlowerShop::Bundle.new(size: i, cost: rand(i)) }
      bundles_order = described_class.new(quantity: 15, bundles: bundles).bundles_order
      expect(bundles_order.class).to eq(Array)
      expect(bundles_order.size).to eq(2)
      expect(bundles_order.first).to eq(9)
      expect(bundles_order.last).to eq(6)
    end
  end

  context 'when order of flowers is 13 and available bundles size are [3,5,9]' do
    it 'selects two bundles of 5 and one of 3' do
      bundles = []
      [3, 5, 9].each { |i| bundles << FlowerShop::Bundle.new(size: i, cost: rand(i)) }
      bundles_order = described_class.new(quantity: 13, bundles: bundles).bundles_order
      expect(bundles_order.class).to eq(Array)
      expect(bundles_order.size).to eq(3)
      expect(bundles_order).to eq([5, 5, 3])
    end
  end

  context 'when order of flowers does not fit the exact bundles sum' do
    it 'bundles the closest possbile bundles collection to order' do
      bundles = []
      [2, 4, 6, 10, 12, 50].each { |i| bundles << FlowerShop::Bundle.new(size: i, cost: rand(i)) }
      bundles_order = described_class.new(quantity: 1859, bundles: bundles).bundles_order
      expect(bundles_order.class).to eq(Array)
      expect(bundles_order.size).to eq(38)
      expect(bundles_order.sum).to eq(1860)
      expect(bundles_order.sum).to be > 1859
      expect(bundles_order.group_by { |x| x }.values.first.size).to eq(37)
      expect(bundles_order.group_by { |x| x }.values.first.sum).to eq(1850)
      expect(bundles_order.group_by { |x| x }.values.last.size).to eq(1)
      expect(bundles_order.group_by { |x| x }.values.last.sum).to eq(10)
    end
  end
end
