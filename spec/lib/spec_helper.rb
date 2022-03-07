# frozen_string_literal: true

require 'simplecov'
require 'shoulda/matchers'
require 'byebug'

require 'flower_shop'

SimpleCov.start
$LOAD_PATH << File.expand_path('../../lib', __dir__)
Dir[File.expand_path(File.join(File.dirname(__FILE__), 'support', '**', '*.rb'))].sort.each { |f| require f }

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
  end
end
