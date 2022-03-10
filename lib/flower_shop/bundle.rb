# frozen_string_literal: true

module FlowerShop
  class Bundle
    attr_accessor :size, :cost

    def initialize(size:, cost:)
      raise ErrorCode.new, ErrorCode::BUNDLE_SIZE_ERROR if size <= 1

      @size = size
      @cost = cost
    end
  end
end
