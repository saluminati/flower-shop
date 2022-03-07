# frozen_string_literal: true

module FlowerShop
  class Config
    attr_accessor :inventory_type, :inventory_meta_deta

    def initialize; end

    def validate
      raise ErrorCode.new ErrorCode::INVENTORY_WRONG_TYPE unless AppConstant::INVENTORY_VALID_TYPES.include?(inventory_type)
      validate_inventory_instructions_array if inventory_type == AppConstant::INVENTORY_TYPE_ARRAY
      valid_inventory_instructions_file if inventory_type == AppConstant::INVENTORY_TYPE_FILE
    end

    private 

    def validate_inventory_instructions_array
      error_obj = ErrorCode.new ErrorCode::INVENTORY_INVALID_META_DATA_ARRAY
      raise error_obj unless inventory_meta_deta.class.to_s == 'Array'
      raise error_obj unless inventory_meta_deta.size.positive?
      raise error_obj if inventory_meta_deta.select {|item| item != '' }.size.zero?
      raise error_obj unless inventory_meta_deta.select {|item| item.class.to_s == 'String' }.size == inventory_meta_deta.size
    end

    def valid_inventory_instructions_file
      error_obj = ErrorCode.new ErrorCode::INVENTORY_INVALID_META_DATA_FILE
      raise error_obj unless inventory_meta_deta.class.to_s == 'String'
      raise error_obj if inventory_meta_deta == ''
    end
  end
end
