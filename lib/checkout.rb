class Checkout
  attr_reader :basket

  def initialize
    @basket = []
  end

  def scan(item)
    @basket << item
  end

  def total
    @basket.map(&:price).inject(:+)
  end
end
