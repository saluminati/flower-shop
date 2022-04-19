# frozen_string_literal: true

module FlowerShop
  # This class sorts fills and sorts bundle by space
  class InventorySorterBySpace
    def initialize(quantity:, bundles:)
      @quantity = quantity
      @bundles = bundles.map(&:size).sort.reverse
      @all_combinations = []
    end

    def bundles_order
      @bundles_order ||= fill_bundles
    end

    private

    # this method itterates from the biggest bundle first
    # fills it as much as it can and then move to the smaller items
    # in the end, it has the combination of all possible bundles
    # our logic chooses the combination which is saving us the max space
    # and equal to or close to the order placed
    def fill_bundles
      return [@bundles.last] if @bundles.select { |b| @quantity >= b }.size.zero?

      filtered_bundles.each { |bundle| fill_bundle(bundle, nil, @quantity) }
      sort_by_space
    end

    # recursive method to use one bundle as anchor point
    # and itterate through all the bundles to fill the desired quantity
    def fill_bundle(bundle, combination, quantity_remaining)
      # this is where we terminate the recursive call
      if quantity_remaining <= 0
        @all_combinations << combination
        return
      end

      combination = [] if combination.nil?

      divident_and_remainder = quantity_remaining.divmod(bundle)
      combination.concat(Array.new(divident_and_remainder.first) { bundle })
      choose_best_fit(combination) if divident_and_remainder.first.zero?
      next_bundle = next_bundle(combination)
      fill_bundle(next_bundle, combination, @quantity - combination.sum)
    end

    # if the current comnbination can not fit the exact desired quantity
    # we need to find the best match from the available bundles
    # once the best match is picked, we need to check if the best match
    # can be combined with the second last bundle and form a bigger bundle
    def choose_best_fit(combination)
      item = @quantity - (combination.sum - combination.last)
      combination[-1] = @bundles.select { |i| i >= item }.reverse.first
      combined_items = @bundles.select { |i| i == (combination[-2] + combination[-1]) }.first
      return unless combined_items

      combination.slice!(-2, 2)
      combination << combined_items
    end

    # This method is there to sort the combinations by length asc order
    # which means the one with the least volume
    def sort_by_space
      final = @all_combinations.sort_by!(&:length).select { |i| i.sum == @quantity }.first
      return @all_combinations.first if final.nil?

      final
    end

    def filtered_bundles
      @filtered_bundles ||= @bundles.select { |b| b <= @quantity }
    end

    # Based on the sum of all the elements in a combination
    # this method picks the best suitable bundle to fill the order
    def next_bundle(combination)
      result = filtered_bundles.reject { |b| combination.sum + b > @quantity }.first
      result.nil? ? filtered_bundles.last : result
    end
  end
end
