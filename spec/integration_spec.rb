require 'spec_helper'
require 'checkout'
require 'item'

describe 'Integration' do
  context 'without promotions' do
    it 'returns the total undiscounted price for all items' do
      co = Checkout.new
      item_1 = Item.new(product_code: '001', name: 'Lavender Heart', price: 9.25)
      item_2 = Item.new(product_code: '002', name: 'Personalised cufflinks', price: 45.00)
      item_3 = Item.new(product_code: '003', name: 'Kid\'s T-shirt', price: 19.95)
      co.scan(item_1)
      co.scan(item_2)
      co.scan(item_3)

      expect(co.total).to eq(74.20)
    end
  end
end
