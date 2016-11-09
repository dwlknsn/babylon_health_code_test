class Checkout
  attr_reader :basket

  def initialize(promotional_rules = [])
    @promotional_rules = promotional_rules
    @basket = []
  end

  def scan(item)
    basket << item
  end

  def total
    subtotal = basket.map(&:price).inject(:+)
    @promotional_rules.each do |rule|
      subtotal *= (100 - rule.percent) / 100
    end
    subtotal
  end
end
