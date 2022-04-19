# frozen_string_literal: true

module FlowerShop
  # Inventory class of the FlowerShop
  # Adding items, sort the inventory by space
  # are the main traits of this class
  class Inventory
    attr_accessor :products, :bundles_order

    def initialize
      @products = []
      @bundles_order = []
    end

    def add_item(inventory_item)
      validate_inventory_item(inventory_item)

      product = find_product_by(product_code: inventory_item.product_code)

      if product.nil?
        products << inventory_item
      else
        inventory_item.bundles.each { |bundle| product.add_bundle(size: bundle.size, cost: bundle.cost) }
      end
    end

    def optimize_bundles(quantity:, product_code:)
      product = find_product_by(product_code: product_code)
      raise_product_not_found_error(product_code) if product.nil?
      validate_bundle_size(product)
      FlowerShop::InventorySorterBySpace.new(quantity: quantity, bundles: product.bundles).bundles_order
    end

    def find_product_by(product_code:)
      product = products.select { |fl| fl.product_code == product_code }.first
      return product unless product.nil?
    end

    private

    def raise_product_not_found_error(product_code)
      error_description = ErrorCode::INVENTORY_PRODUCT_NOT_FOUND.dup
      error_description.sub!('_item_', product_code).sub!('_item2_', products.map(&:product_code).join(','))
      raise ErrorCode, error_description
    end

    def validate_bundle_size(product)
      return if product.bundles.size.positive?

      error_description = ErrorCode::INVENTORY_BUNDLES_EMPTY.dup.sub!('_item_', product.product_code)
      raise ErrorCode, error_description
    end

    def validate_inventory_item(inventory_item)
      raise ErrorCode, ErrorCode::INVENTORY_WRONG_ITEM_INSERT unless inventory_item.class.to_s == 'FlowerShop::Flower'
    end
  end
end
