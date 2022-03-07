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
end
