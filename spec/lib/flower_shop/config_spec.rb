# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe FlowerShop::Config do
  describe '#validate' do
    context 'when wrong inventory_type is provided' do
      it 'will raise exception if inventory_type is wrong' do
        expect do
          described_class.new('wrong inventory type', 'adfadf').validate
        end.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_WRONG_TYPE)
      end
    end

    context 'when inventory_type is array' do
      it 'will raise exception if inventory_meta_deta is not of type Array' do
        expect do
          described_class.new('array', 'adfadf').validate
        end.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_INVALID_META_DATA_ARRAY)
      end

      it 'will raise exception if any element of inventory_meta_deta is not of type String' do
        expect do
          described_class.new('array', ['test', 400]).validate
        end.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_INVALID_META_DATA_ARRAY)
      end

      it 'will raise exception if any element of inventory_meta_deta is empty' do
        expect do
          described_class.new('array', []).validate
        end.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_INVALID_META_DATA_ARRAY)
      end
    end

    context 'when inventory_type is file' do
      it 'will raise exception if any element of inventory_meta_deta is not of type String' do
        expect do
          described_class.new('file', 500).validate
        end.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_INVALID_META_DATA_FILE)
      end

      it 'will raise exception if any element of inventory_meta_deta is empty String' do
        expect do
          described_class.new('file', '').validate
        end.to raise_error(FlowerShop::ErrorCode, FlowerShop::ErrorCode::INVENTORY_INVALID_META_DATA_FILE)
      end
    end
  end
end
