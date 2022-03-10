# frozen_string_literal: true

# This class sorts fills and sorts bundle by space
module FlowerShop
  class InventorySorterBySpace
    attr_accessor :bundles_order

    def initialize(quantity:, bundles:)
      @quantity = quantity
      @bundles = bundles.map(&:size).sort.reverse
      # quantity_remaining = @quantity
      # combinations = []

      @bundles_order = fill_bundles
    end

    private

    # this code tries insert biggest items first
    def fill_bundles
      all_comnbinations = []
      combinations = []
      quantity_remaining = 0

      @bundles.each do |bundle|
        combinations = []
        quantity_remaining = @quantity
        divident = quantity_remaining.div(bundle)
        remainder = quantity_remaining.modulo(bundle)
        quantity_remaining = remainder

        combinations.concat(Array.new(divident) { bundle })

        @bundles.each_with_index do |inner_bundle, _index|
          next if inner_bundle == bundle
          break if quantity_remaining <= 0

          divident = quantity_remaining.div(inner_bundle)
          remainder = quantity_remaining.modulo(inner_bundle)
          next_bunles = Array.new(divident) { inner_bundle }

          next if (next_bunles.sum + combinations.sum) > @quantity

          combinations.concat(next_bunles)
        end
        otimize_space(combinations) if combinations.sum < @quantity
        all_comnbinations << combinations
      end
      sort_by_space(all_comnbinations)
    end

    def otimize_space(c)
      item = @quantity - (c.sum - c.last)
      c[-1] = @bundles.select { |i| i >= item }.reverse.first
    end

    def sort_by_space(all_c)
      final = all_c.sort_by!(&:length).select { |i| i.sum == @quantity }.first
      return all_c.first if final.nil?

      final
    end
  end
end
