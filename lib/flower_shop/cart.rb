# frozen_string_literal: true

module FlowerShop
  # Class that contains that holds the shopping cart
  class Cart
    attr_accessor :product, :cart, :bundles

    def initialize(product:, bundles:, quantity:)
      @product = product
      @bundles = bundles
      @quantity = quantity
    end

    def print_order
      cart = create_cart
      puts "#{cart[:quantity]} #{cart[:product_code]} $#{cart[:sum]}"
      cart[:bundles].group_by { |x| x }.each_value do |bundle|
        puts "#{bundle.flatten.size} x #{bundle.flatten.first.size} $#{bundle.flatten.map(&:cost).inject(0, &:+)}"
      end
    end

    def create_cart
      sorted_bundles = []
      @bundles.each { |sb| sorted_bundles << @product.bundles.select { |b| b.size == sb }.first }
      sum = sorted_bundles.map(&:cost).inject(0, &:+)
      grouped = sorted_bundles.group_by { |x| x }.values

      { quantity: @quantity, product_code: @product.product_code, bundles: grouped, sum: sum }
    end
  end
end
