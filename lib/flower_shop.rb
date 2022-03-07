# frozen_string_literal: true

require_relative 'flower_shop/constants/error_code'
require_relative 'flower_shop/constants/app_constant'
require_relative 'flower_shop/config'

# Entry point namespace of this gem
module FlowerShop
  module_function

  def config
    @config ||= Config.new
  end

  def configure
    yield config
    config.validate
  end

end
