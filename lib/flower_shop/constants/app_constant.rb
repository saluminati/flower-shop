# frozen_string_literal: true

# Entry point namespace of this gem
module FlowerShop
  class AppConstant
    INVENTORY_TYPE_FILE = 'file'
    INVENTORY_TYPE_ARRAY = 'array'
    INVENTORY_VALID_TYPES = [INVENTORY_TYPE_FILE, INVENTORY_TYPE_ARRAY].freeze
  end
end
