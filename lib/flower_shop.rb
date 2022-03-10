# frozen_string_literal: true

require_relative 'flower_shop/constants/error_code'
require_relative 'flower_shop/constants/app_constant'
require_relative 'flower_shop/config'
require_relative 'flower_shop/flower'
require_relative 'flower_shop/bundle'
require_relative 'flower_shop/inventory'
require_relative 'flower_shop/utils/inventory_loader'
require_relative 'flower_shop/utils/inventory_sorter_by_space'

# Entry point namespace of this gem
module FlowerShop
  module_function

  def config
    @config ||= Config.new
  end

  def configure
    yield config
  end

  def inventory_items
    InventoryLoader.new(@config.inventory_type, @config.inventory_meta_deta).inventory_items
  end

  def inventory
    load_inventory
  end

  def place_order(quantity:, product_code:)
    inventory.place_order(quantity: quantity, product_code: product_code)
  end

  def load_inventory
    temp = Inventory.new
    inventory_items.each { |it| temp.add_item(it) }
    temp
  end
end
