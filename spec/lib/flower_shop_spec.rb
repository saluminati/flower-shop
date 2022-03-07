# frozen_string_literal: true

require_relative './spec_helper'

RSpec.describe FlowerShop do

  describe '.config' do
    context 'when wrong inventory_type is provided' do
      it 'will raise INVENTORY_WRONG_TYPE exception' do
        expect {
        described_class.configure do |config|
          config.inventory_type = 'wrong inventory type'
          config.inventory_meta_deta = 'adfadf'
        end
      }.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_WRONG_TYPE)
      end
    end

    context 'when inventory_type is array' do
      it 'will raise exception if inventory_meta_deta is not of type Array' do
        expect {
        described_class.configure do |config|
          config.inventory_type = 'array'
          config.inventory_meta_deta = 'adfadf'
        end
      }.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_INVALID_META_DATA_ARRAY)
      end

      it 'will raise exception if any element of inventory_meta_deta is not of type String' do
        expect {
        described_class.configure do |config|
          config.inventory_type = 'array'
          config.inventory_meta_deta = ['test', 400]
        end
      }.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_INVALID_META_DATA_ARRAY)
      end

      it 'will raise exception if any element of inventory_meta_deta is empty' do
        expect {
        described_class.configure do |config|
          config.inventory_type = 'array'
          config.inventory_meta_deta = []
        end
      }.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_INVALID_META_DATA_ARRAY)
      end
    end

    context 'when inventory_type is file' do
      it 'will raise exception if any element of inventory_meta_deta is not of type String' do
        expect {
        described_class.configure do |config|
          config.inventory_type = 'file'
          config.inventory_meta_deta = 500
        end
      }.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_INVALID_META_DATA_FILE)
      end

      it 'will raise exception if any element of inventory_meta_deta is empty String' do
        expect {
        described_class.configure do |config|
          config.inventory_type = 'file'
          config.inventory_meta_deta = ''
        end
      }.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_INVALID_META_DATA_FILE)
      end
    end
    
  end
end
