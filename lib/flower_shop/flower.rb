# frozen_string_literal: true

module FlowerShop
  # Class that represents a flower object
  class Flower
    attr_accessor :kind, :product_code, :category, :bundles

    def initialize(kind:, product_code:, category:)
      @kind = kind
      @product_code = product_code
      @category = category
      @bundles = []
    end

    def add_bundle(size:, cost:)
      @bundles << Bundle.new(size: size.to_i, cost: cost.to_f)
    end
  end
end
