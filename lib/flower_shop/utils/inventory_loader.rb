# frozen_string_literal: true

module FlowerShop
  class InventoryLoader
    attr_accessor :inventory_items

    def initialize(inventory_type, inventory_meta_data)
      @inventory_type = inventory_type
      @inventory_meta_data = inventory_meta_data
      @inventory_items = []
      load_inventory
      validate_inventory_items
    rescue Errno::ENOENT
      raise ErrorCode.new, ErrorCode::FILE_NOT_EXIST
    end

    private

    def load_inventory
      unless AppConstant::INVENTORY_VALID_TYPES.include?(@inventory_type)
        raise ErrorCode,
              ErrorCode::INVENTORY_WRONG_TYPE
      end

      case @inventory_type
      when AppConstant::INVENTORY_TYPE_FILE
        @inventory_items = File.readlines(@inventory_meta_data, chomp: true)
      when AppConstant::INVENTORY_TYPE_ARRAY
        @inventory_items = @inventory_meta_data
      end
    end

    def validate_inventory_items
      error_obj = ErrorCode.new ErrorCode::INVENTORY_INVALID_META_DATA_ARRAY
      raise error_obj unless @inventory_items.class.to_s == 'Array'
      raise error_obj unless @inventory_items.size.positive?

      @inventory_items.each { |meta_item| validate_meta_item(meta_item) }
    rescue TypeError
      raise error_obj
    end

    def load_inventory_from_array
      error_obj = ErrorCode.new ErrorCode::INVENTORY_INVALID_META_DATA_ARRAY
      raise error_obj unless @inventory_meta_data.class.to_s == 'Array'
      raise error_obj unless @inventory_meta_data.size.positive?

      validate_meta_items(@inventory_meta_data)
      @inventory_items = @inventory_meta_data
    rescue TypeError
      raise error_obj
    end

    def validate_meta_items(meta_items)
      meta_items.each { |meta_item| validate_meta_item(meta_item) }
    end

    def validate_meta_item(meta_item)
      return unless AppConstant::INVENTORY_ITEM_REGEX.match(meta_item).nil?

      raise ErrorCode, ErrorCode::INVENTORY_ITEM_WRONG_FORMAT.dup.sub!('_item_', meta_item)
    end
  end
end
