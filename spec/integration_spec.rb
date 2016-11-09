require 'spec_helper'
require 'checkout'
require 'item'
require 'promotional_rule'

describe 'Integration' do
  context 'without promotions' do
    it 'returns the total undiscounted price for all items' do
      co = Checkout.new
      item_1 = build_item(product_code: '001')
      item_2 = build_item(product_code: '002')
      item_3 = build_item(product_code: '003')
      co.scan(item_1)
      co.scan(item_2)
      co.scan(item_3)

      expect(co.total).to eq(74.20)
    end
  end

  context 'with promotions' do
    context 'total_order promotion' do
      context 'min_spend_limit exceeded' do
        it 'applies the discount to the total order' do
          rule = PromotionalRule.new(type: :total_order, percent: 10)
          promotional_rules = [rule]
          co = Checkout.new(promotional_rules)
          item_1 = build_item(product_code: '001')
          item_2 = build_item(product_code: '002')
          item_3 = build_item(product_code: '003')
          co.scan(item_1)
          co.scan(item_2)
          co.scan(item_3)

          expect(co.total).to eq(66.78)
        end
      end

      context 'min_spend_limit NOT exceeded' do
        it 'does not apply discount' do
          rule = PromotionalRule.new(type: :total_order, percent: 10, min_spend_limit: 100.00)
          promotional_rules = [rule]
          co = Checkout.new(promotional_rules)
          item_1 = build_item(product_code: '001')
          item_2 = build_item(product_code: '002')
          item_3 = build_item(product_code: '003')
          co.scan(item_1)
          co.scan(item_2)
          co.scan(item_3)

          expect(co.total).to eq(74.20)
        end
      end
    end

    context 'product promotion' do
      context 'min_quantity_limit exceeded' do
        it 'reduces the product price by the amount specified' do
          rule = PromotionalRule.new(type: :product, discount: 0.75, product_code: '001', min_quantity_limit: 2)
          promotional_rules = [rule]
          co = Checkout.new(promotional_rules)
          co.scan(build_item(product_code: '001'))
          co.scan(build_item(product_code: '003'))
          co.scan(build_item(product_code: '001'))

          price = co.total

          expect(price).to eq(36.95)
        end
      end

      context 'min_quantity_limit NOT exceeded' do
        it 'does not reduce the product price' do
          rule = PromotionalRule.new(type: :product, discount: 0.75, product_code: '001', min_quantity_limit: 3)
          promotional_rules = [rule]
          co = Checkout.new(promotional_rules)
          co.scan(build_item(product_code: '001'))
          co.scan(build_item(product_code: '003'))
          co.scan(build_item(product_code: '001'))

          price = co.total

          expect(price).to eq(38.45)
        end
      end
    end
  end
end


def build_item(product_code:)
  case product_code
  when '001'
    Item.new(product_code: '001', name: 'Lavender Heart', price: 9.25)
  when '002'
    Item.new(product_code: '002', name: 'Personalised cufflinks', price: 45.00)
  when '003'
    Item.new(product_code: '003', name: 'Kid\'s T-shirt', price: 19.95)
  end
end
