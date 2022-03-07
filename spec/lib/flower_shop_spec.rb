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
end
