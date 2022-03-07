# frozen_string_literal: true

module FlowerShop
  class Bundle
    attr_accessor :size, :cost

    def initialize(size:, cost:)
      @size = size
      @cost = cost
    end
  end
end
