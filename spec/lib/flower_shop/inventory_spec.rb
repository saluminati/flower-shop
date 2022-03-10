# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe FlowerShop::Inventory do
  let(:sun_flower) { FlowerShop::Flower.new(kind: 'Sun Flower', product_code: 'S180', category: 'Orange one') }
  let(:rose) { FlowerShop::Flower.new(kind: 'Rose', product_code: 'A80', category: 'Pink') }
  let(:inventory) { described_class.new }

  describe '#add_item' do
    it 'mutates flowers - or should I say blossoms flowers' do
      inventory.add_item(sun_flower)
      expect(inventory.products.size).to eq(1)
      inventory.add_item(rose)
      expect(inventory.products.size).to eq(2)
    end

    context 'When ventory item is not of type FlowerShop::Flower' do
      it {
        expect do
          inventory.add_item(Array)
        end.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_WRONG_ITEM_INSERT)
      }
    end

    context 'when same product code item is repeated' do
      it 'adds to the product item bundles' do
        meta_data = ['Rose Anita A80 5@40', 'Rose Anita A80 10@60']
        inventory_items = FlowerShop::InventoryLoader.new('array', meta_data).inventory_items
        inventory_items.each { |i| inventory.add_item(i) }
        expect(inventory.products.size).to eq(1)
        expect(inventory.products.first.bundles.size).to eq(2)
      end
    end
  end

  describe '#find_product_by' do
    it 'finds the flower by product code' do
      # rose.add_bundle(size: 5, cost:20)
      inventory.add_item(rose)
      flower = inventory.find_product_by(product_code: 'A80')
      expect(flower.product_code).to eq('A80')
    end
  end

  describe '#place_order' do
    before do
      inventory.add_item(sun_flower)
      inventory.add_item(rose)
    end

    context 'when the product code does not exist in the inventory' do
      it {
        expect do
          inventory.place_order(quantity: 50, product_code: 'A8033')
        end.to raise_error(FlowerShop::ErrorCode,
                           'Inventory Error: A8033 not found. Please check your product code. Available product codes : S180,A80')
      }
    end

    context 'when the product code exist but bundles are empty' do
      it {
        expect do
          inventory.add_item(sun_flower)
          inventory.place_order(quantity: 50, product_code: 'S180')
        end.to raise_error(FlowerShop::ErrorCode,
                           'Inventory Error: Product code(S180). Does not have any bundles.')
      }
    end

    it 'bundles the optimized and exact order size if possible' do
      [3, 6, 9].each { |i| sun_flower.add_bundle(size: i, cost: rand(1..100)) }
      inventory.place_order(quantity: 51, product_code: 'S180')
      expect(inventory.bundles_order.sum).to eq(51)
      expect(inventory.bundles_order.size).to eq(6)
    end

    context 'when order of flowers does not fit the exact bundles sum' do
      it 'bundles the closest possbile bundles collection to order' do
        [3, 6, 9].each { |i| sun_flower.add_bundle(size: i, cost: rand(1..100)) }
        inventory.place_order(quantity: 50, product_code: 'S180')
        expect(inventory.bundles_order.sum).to eq(51)
        expect(inventory.bundles_order.size).to eq(6)
      end
    end
  end
end
