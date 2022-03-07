# frozen_string_literal: true

require_relative '../../spec_helper'

RSpec.describe FlowerShop::InventoryLoader do
  context 'when inventory_type is wrong' do
    it {
      expect do
        described_class.new('wrong inventory type', 'adfadf').validate
      end.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_WRONG_TYPE)
    }
  end

  context 'when valid inventory_type is array' do
    it 'mutates the inventory_items' do
      meta_data = ['Rose Anita A80 5@40', 'Rose Ballerina b22 10@40.33']
      expect(described_class.new('array', meta_data).inventory_items.size).to eq(2)
    end

    it 'raises exception if any inventory_meta_data item format is invalid' do
      inventory_items = ['Rose Anita A80 5@40', 'Anita A80 5@40']
      error_message = FlowerShop::ErrorCode::INVENTORY_ITEM_WRONG_FORMAT.dup.gsub '_item_', inventory_items.last
      expect do
        described_class.new('array', inventory_items)
      end.to raise_error(FlowerShop::ErrorCode, error_message)
    end
  end

  context 'when valid inventory_type is file with a valid file path' do
    it 'mutates the inventory_items' do
      inventory = described_class.new('file', File.expand_path('spec/support/valid_inventory_items.txt'))
      expect(inventory.inventory_items.size).to eq(2)
    end
  end

  context 'when valid inventory_type is file with a valid path' do
    it 'will mutate the inventory_items' do
      inventory = described_class.new('file', File.expand_path('spec/support/valid_inventory_items.txt'))
      expect(inventory.inventory_items.size).to eq(2)
    end
  end

  context 'when valid inventory_type is file with a valid path but errors in the format' do
    it 'will raise exception' do
      error_message = FlowerShop::ErrorCode::INVENTORY_ITEM_WRONG_FORMAT.dup.gsub '_item_', 'Rose Random 10@40.33'
      expect do
        described_class.new('file', File.expand_path('spec/support/invalid_inventory_items.txt'))
      end.to raise_error(FlowerShop::ErrorCode, error_message)
    end
  end

  context 'when valid inventory_type is file with an invalid file path' do
    it 'will raise exception' do
      expect do
        inventory = described_class.new('file', File.expand_path('spec/support/valid_inventory_itemsss.txt'))
      end.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::FILE_NOT_EXIST)
    end
  end
end
