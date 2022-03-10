# frozen_string_literal: true

require_relative '../../spec_helper'

RSpec.describe FlowerShop::InventoryLoader do
  context 'when invalid inventory_type is provided' do
    it {
      expect do
        described_class.new('wrong inventory type', 'adfadf')
      end.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_WRONG_TYPE)
    }

    it {
      expect do
        described_class.new('', 'adfadf')
      end.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_WRONG_TYPE)
    }

    it {
      expect do
        described_class.new(nil, 'adfadf')
      end.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_WRONG_TYPE)
    }
  end

  it 'accept space or comma as a seperator' do
    meta_data_comma = ['Rose,Anita,A80,5@40', 'Rose,Ballerina,b22,10@40.33']
    meta_data_space = ['Rose Anita A80 5@40', 'Rose Ballerina b22 10@40.33']
    expect(described_class.new('array', meta_data_comma).inventory_items.size).to eq(2)
    expect(described_class.new('array', meta_data_space).inventory_items.size).to eq(2)
  end

  it 'populates correct inventory items' do
    loader = described_class.new('array', ['Rose,Anita,A80,5@40', 'Rose,Ballerina,b22,10@40.33'])

    expect(loader.inventory_items.size).to eq(2)
    expect(loader.inventory_items.first.kind).to eq('Rose')
    expect(loader.inventory_items.first.category).to eq('Anita')
    expect(loader.inventory_items.first.product_code).to eq('A80')
    expect(loader.inventory_items.first.bundles.first.size).to eq(5)
    expect(loader.inventory_items.first.bundles.first.cost).to eq(40)

    expect(loader.inventory_items.size).to eq(2)
    expect(loader.inventory_items.last.kind).to eq('Rose')
    expect(loader.inventory_items.last.category).to eq('Ballerina')
    expect(loader.inventory_items.last.product_code).to eq('b22')
    expect(loader.inventory_items.last.bundles.first.size).to eq(10)
    expect(loader.inventory_items.last.bundles.first.cost).to eq(40.33)
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

    it 'raises exception if inventory_meta_deta is not of type Array' do
      expect do
        described_class.new('array', 'adfadf').validate
      end.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_INVALID_META_DATA_ARRAY)
    end

    it 'raises exception if any element of inventory_meta_deta is not of type String' do
      expect do
        described_class.new('array', ['Rose Anita A80 5@40', 400])
      end.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_INVALID_META_DATA_ARRAY)
    end

    it 'raises exception if any element of inventory_meta_deta is empty' do
      expect do
        described_class.new('array', [])
      end.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_INVALID_META_DATA_ARRAY)
    end
  end

  context 'when valid inventory_type is file with a valid file path' do
    it 'mutates the inventory_items' do
      inventory = described_class.new('file', File.expand_path('spec/support/valid_inventory_items.txt'))
      expect(inventory.inventory_items.size).to eq(2)
    end
  end

  context 'when valid inventory_type is file with a valid path' do
    it 'mutates the inventory_items' do
      inventory = described_class.new('file', File.expand_path('spec/support/valid_inventory_items.txt'))
      expect(inventory.inventory_items.size).to eq(2)
    end
  end

  context 'when valid inventory_type is file with a valid path but errors in the format' do
    it 'raises exception' do
      error_message = FlowerShop::ErrorCode::INVENTORY_ITEM_WRONG_FORMAT.dup.gsub '_item_', 'Rose Random 10@40.33'
      expect do
        described_class.new('file', File.expand_path('spec/support/invalid_inventory_items.txt'))
      end.to raise_error(FlowerShop::ErrorCode, error_message)
    end
  end

  context 'when valid inventory_type is file with an invalid file path' do
    it 'raises exception' do
      expect do
        described_class.new('file', File.expand_path('spec/support/valid_inventory_itemsss.txt'))
      end.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::FILE_NOT_EXIST)
    end
  end
end
