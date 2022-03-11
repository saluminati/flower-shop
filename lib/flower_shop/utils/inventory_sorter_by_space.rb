# frozen_string_literal: true

# This class sorts fills and sorts bundle by space
module FlowerShop
  class InventorySorterBySpace
    attr_accessor :bundles_order

    def initialize(quantity:, bundles:)
      @quantity = quantity
      @bundles = bundles.map(&:size).sort.reverse
      @bundles_order = fill_bundles
    end

    private

    # this method itterates from the biggest bundle first
    # fills it as much as it can and then move to the smaller items
    # in the end, it has the combination of all possible bundles
    # our logic chooses the combination which is saving us the max space
    # and equal to or close to the order placed
    def fill_bundles
      return [@bundles.last] if @bundles.select { |b| @quantity >= b }.size.zero?

      all_comnbinations = []
      combinations = []
      quantity_remaining = 0

      filtered_bundles.each do |bundle|
        combinations = []
        quantity_remaining = @quantity
        divident = quantity_remaining.div(bundle)
        remainder = quantity_remaining.modulo(bundle)
        quantity_remaining = remainder

        combinations.concat(Array.new(divident) { bundle })

        filtered_bundles.each_with_index do |inner_bundle, _index|
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

    # if the current comnbination can not fit the exact order
    # we need to find the best match from the available bundles
    def otimize_space(c)
      item = @quantity - (c.sum - c.last)
      c[-1] = @bundles.select { |i| i >= item }.reverse.first
    end

    def sort_by_space(all_c)
      final = all_c.sort_by!(&:length).select { |i| i.sum == @quantity }.first
      return all_c.first if final.nil?

      final
    end

    def filtered_bundles
      @filtered_bundles ||= @bundles.select { |b| b <= @quantity }
    end
  end
end
