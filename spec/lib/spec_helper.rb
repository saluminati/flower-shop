# frozen_string_literal: true


require 'simplecov'
require 'shoulda/matchers'

require 'flower_shop'

SimpleCov.start

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
  end
end
