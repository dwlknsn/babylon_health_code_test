class Checkout
  attr_reader :basket

  def initialize(promotional_rules = [])
    @promotional_rules = promotional_rules
    @basket = []
  end

  def scan(item)
    basket << item
  end

  def remove(item)
    basket.delete(item)
  end

  def clear
    basket.clear
  end

  def total
    apply_product_promotions
    apply_total_order_promotions

    subtotal(basket)
  end

  private

  attr_reader :promotional_rules

  def apply_product_promotions
    product_promotions.each do |rule|
      items = basket.select { |item| item.product_code == rule.product_code }
      apply_discount(items, rule)
    end
  end

  def apply_total_order_promotions
    total_order_promotions.each { |rule| apply_discount(basket, rule) }
  end


  def product_promotions
    @product_promotions ||= promotional_rules.select do |rule|
      rule.type == :product
    end
  end

  def total_order_promotions
    @total_order_promotions ||= promotional_rules.select do |rule|
      rule.type == :total_order
    end
  end

  def apply_discount(items, rule)
    min_quantity_exceeded = items.length >= rule.min_quantity_limit
    min_spend_exceeded = subtotal(items) >= rule.min_spend_limit

    items.each do |item|
      item.price -= rule.discount if min_quantity_exceeded
      item.price *= (100 - rule.percent) / 100 if min_spend_exceeded
    end
  end

  def subtotal(items)
    items.map(&:price).inject(:+).round(2)
  end
end
