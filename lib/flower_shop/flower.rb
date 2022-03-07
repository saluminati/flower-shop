# frozen_string_literal: true

module FlowerShop
  class Flower
    attr_accessor :kind, :product_code, :category, :bundles

    def initialize(kind:, product_code:, category:)
      @kind = kind
      @product_code = product_code
      @category = category
      @bundles = []
    end

    def add_bundle(size:, cost:)
      @bundles << Bundle.new(size: size, cost: cost)
    end
  end
end
