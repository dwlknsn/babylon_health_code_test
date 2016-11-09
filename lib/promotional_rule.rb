class PromotionalRule
  attr_reader :type, :product_code, :percent, :discount, :min_spend_limit,
              :min_quantity_limit

  def initialize(args = {})
    @type = args[:type]
    @product_code = args[:product_code]
    @percent = args[:percent].to_f                  || 0.00
    @discount = args[:discount].to_f                || 0.00
    @min_spend_limit = args[:min_spend_limit].to_f  || 0.00
    @min_quantity_limit = args[:min_quantity_limit] || 0
  end
end
