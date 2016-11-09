require 'spec_helper'
require 'checkout'

describe Checkout do
  describe '#scan' do
    it 'adds the item to the basket' do
      co = Checkout.new
      item_1 = double(:item)
      item_2 = double(:item)
      co.scan(item_1)
      co.scan(item_2)

      expect(co.basket).to eq([item_1, item_2])
    end
  end

  describe '#total' do
    it 'sums the prices of the items in the basket' do
      co = Checkout.new
      item_1 = double(:item, price: 5.00)
      item_2 = double(:item, price: 10.00)
      co.scan(item_1)
      co.scan(item_2)

      expect(co.total).to eq(15.00)
    end
  end
end
