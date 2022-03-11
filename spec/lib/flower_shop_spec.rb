# frozen_string_literal: true

require_relative './spec_helper'

RSpec.describe FlowerShop do
  describe '.configure' do
    it 'will mutate the config for the flower shop' do
      described_class.configure do |config|
        config.inventory_type = 'anything'
        config.inventory_meta_deta = 'something'
      end
      expect(described_class.config.inventory_type).to eq('anything')
      expect(described_class.config.inventory_meta_deta).to eq('something')
    end
  end

  describe '.inventory_items' do
    it 'mutates the @inventory_items' do
      described_class.configure do |config|
        config.inventory_type = 'array'
        config.inventory_meta_deta = ['Rose Anita A80 5@40', 'Rose Ballerina b22 10@40.33']
      end

      expect(described_class.inventory_items.class).to eq(Array)
      expect(described_class.inventory_items.size).to eq(2)
    end
  end

  describe '.inventory' do
    it 'mutates the @inventory with flowers and bundles' do
      described_class.configure do |config|
        config.inventory_type = 'array'
        config.inventory_meta_deta = ['Rose Anita A80 5@40', 'Rose Ballerina b22 10@40.33']
      end

      expect(described_class.inventory.class).to eq(FlowerShop::Inventory)
      expect(described_class.inventory_items.size).to eq(2)
    end
  end

  describe '.place_order' do
    it 'places the order containing minimal bundles equal to or closest to the desired order' do
      described_class.configure do |config|
        config.inventory_type = 'array'
        config.inventory_meta_deta = ['Rose Anita A80 5@40', 'Rose Anita A80 10@60']
      end

      cart = described_class.place_order(quantity: 25, product_code: 'A80').create_cart
      expect(cart[:quantity]).to eq(25)
      expect(cart[:product_code]).to eq('A80')
      expect(cart[:bundles].size).to eq(2)
      expect(cart[:bundles].first.size).to eq(2)
      expect(cart[:bundles].last.size).to eq(1)
      expect(cart[:sum]).to eq(160.0)
    end
  end
end
