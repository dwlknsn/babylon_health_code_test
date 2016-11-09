class Item
  attr_accessor :price
  attr_reader :product_code, :name

  PRODUCT_LIST = {
    product_001: { product_code: '001', name: 'Lavender Heart', price: 9.25 },
    product_002: { product_code: '002', name: 'Personalised cufflinks', price: 45.00 },
    product_003: { product_code: '003', name: 'Kid\'s T-shirt', price: 19.95 }
  }

  def self.build(product_code:)
    new(PRODUCT_LIST["product_#{product_code}".to_sym])
  end

  def initialize(product_code:, name:, price:)
    @product_code = product_code
    @name = name
    @price = price
  end
end
