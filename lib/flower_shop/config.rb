# frozen_string_literal: true

module FlowerShop
  class Config
    attr_accessor :inventory_type, :inventory_meta_deta

    def initialize(inventory_type = nil, inventory_meta_deta = nil)
      @inventory_type = inventory_type
      @inventory_meta_deta = inventory_meta_deta
    end
  end
end
