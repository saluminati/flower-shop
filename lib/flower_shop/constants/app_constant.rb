# frozen_string_literal: true

# Entry point namespace of this gem
module FlowerShop
  class AppConstant
    INVENTORY_TYPE_FILE = 'file'
    INVENTORY_TYPE_ARRAY = 'array'
    INVENTORY_VALID_TYPES = [INVENTORY_TYPE_FILE, INVENTORY_TYPE_ARRAY].freeze
    INVENTORY_ITEM_REGEX = /[a-zA-Z]*[^\s,][\s|,]{1}[a-zA-Z]*[^\s][\s|,]{1}\w\d*[\s|,]{1}\d*@[+]?\d*\.?\d+$/.freeze
    INVENTORY_ITEM_SEPERATOR = /[,\s]+/.freeze
    INVENTORY_BUNDLE_SEPERATOR = '@'
  end
end
