# frozen_string_literal: true

require_relative 'flower_shop/constants/error_code'
require_relative 'flower_shop/constants/app_constant'
require_relative 'flower_shop/config'
require_relative 'flower_shop/flower'
require_relative 'flower_shop/bundle'
require_relative 'flower_shop/utils/inventory_loader'

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
    @inventory_items ||= InventoryLoader.new(@config.inventory_type, @config.inventory_meta_deta).inventory_items
  end
end
