class Item
  attr_reader :price

  def initialize(product_code:, name:, price:)
    @product_code = product_code
    @name = name
    @price = price
  end
end
