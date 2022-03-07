# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe FlowerShop::Config do
  it { expect(described_class.new('array', ['random stuff']).inventory_type).to eq('array') }
  it { expect(described_class.new('file', 'some value').inventory_type).to eq('file') }
  it { expect(described_class.new('random', 'something random').inventory_type).to eq('random') }
end
