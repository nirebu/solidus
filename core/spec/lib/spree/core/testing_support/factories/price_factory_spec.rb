ENV['NO_FACTORIES'] = "NO FACTORIES"

require 'spec_helper'
require 'spree/testing_support/factories/price_factory'

RSpec.describe 'price factory' do
  let(:factory_class) { Spree::Price }

  describe 'plain price' do
    let(:factory) { :price }

    it_behaves_like 'a working factory'
  end
end
