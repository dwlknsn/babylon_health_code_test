class Item
  attr_accessor :price
  attr_reader :product_code

  def initialize(product_code:, name:, price:)
    @product_code = product_code
    @name = name
    @price = price
  end
end
