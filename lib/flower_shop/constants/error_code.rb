# frozen_string_literal: true

require_relative 'app_constant'
module FlowerShop
  class ErrorCode < StandardError
    FILE_NOT_EXIST = 'Unable to read the file. Please make sure that the path is valid'
    CONFIG_EMPTY_VALUE = 'Config Error: inventory_type and inventory_meta_deta can not be nil or empty'
    INVENTORY_WRONG_TYPE = "Inventory Error: Valid inventory types are #{AppConstant::INVENTORY_VALID_TYPES.join(' or ')} "
    INVENTORY_INVALID_META_DATA_ARRAY = 'Inventory Error: Meta data should be Array of non empty strings'
    INVENTORY_INVALID_META_DATA_FILE = 'Inventory Error: Meta data can only be of a non empty string containing file path'
    INVENTORY_ITEM_WRONG_FORMAT = 'Inventory Item Format Error: _item_ is not valid. Please refer to README'
    INVENTORY_WRONG_ITEM_INSERT = 'Inventory Item Format Error: You can only pass FlowerShop::Flower object as an argument to the add_item method'
    INVENTORY_PRODUCT_NOT_FOUND = 'Inventory Error: _item_ not found. Please check your product code. Available product codes : _item2_'
    INVENTORY_BUNDLES_EMPTY = 'Inventory Error: Product code(_item_). Does not have any bundles.'
  end
end
