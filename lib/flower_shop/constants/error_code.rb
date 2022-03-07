# frozen_string_literal: true

require_relative 'app_constant'
module FlowerShop
  class ErrorCode < StandardError
    FILE_NOT_EXIST = 'Unable to read the file. Please make sure that the path is valid'
    INVENTORY_WRONG_TYPE = "Inventory Error: Valid inventory types are #{AppConstant::INVENTORY_VALID_TYPES.join(' or ')} "
    INVENTORY_INVALID_META_DATA_ARRAY = 'Inventory Error: Meta data should be Array of non empty strings'
    INVENTORY_INVALID_META_DATA_FILE = 'Inventory Error: Meta data can only be of a non empty string containing file path'
    INVENTORY_ITEM_WRONG_FORMAT = 'Inventory Item Format Error: _item_ is not valid. Please refer to README'
  end
end
