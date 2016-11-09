require 'spec_helper'
require 'item'

describe Item do
  describe '.build' do
    it 'builds the item from the product list' do
      item_1 = Item.build(product_code: '001')

      expect(item_1).to be_an(Item)
      expect(item_1.product_code).to eq('001')
      expect(item_1.name).to eq('Lavender Heart')
      expect(item_1.price).to eq(9.25)
    end
  end
end
