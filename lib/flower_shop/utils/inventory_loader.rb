# frozen_string_literal: true

module FlowerShop
  class InventoryLoader
    attr_accessor :inventory_items

    def initialize(inventory_type, inventory_meta_data)
      @inventory_type = inventory_type
      @inventory_meta_data = inventory_meta_data
      @inventory_items = []
      @meta_items = []
      load_inventory
      validate_inventory_items
      populate_inventory_items
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
        @meta_items = File.readlines(@inventory_meta_data, chomp: true)
      when AppConstant::INVENTORY_TYPE_ARRAY
        @meta_items = @inventory_meta_data
      end
    end

    def validate_inventory_items
      error_obj = ErrorCode.new ErrorCode::INVENTORY_INVALID_META_DATA_ARRAY
      raise error_obj unless @meta_items.class.to_s == 'Array'
      raise error_obj unless @meta_items.size.positive?

      @meta_items.each { |meta_item| validate_meta_item(meta_item) }
    rescue TypeError
      raise error_obj
    end

    def populate_inventory_items
      @meta_items.each do |meta_item|
        data = meta_item.split(AppConstant::INVENTORY_ITEM_SEPERATOR)
        bundle_data = data.last.split(AppConstant::INVENTORY_BUNDLE_SEPERATOR)

        flower = Flower.new(kind: data[0], category: data[1], product_code: data[2])
        flower.add_bundle(size: bundle_data[0], cost: bundle_data[1])
        @inventory_items << flower
      end
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
