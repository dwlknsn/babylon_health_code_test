class PromotionalRule
  attr_reader :percent, :min_spend_limit

  def initialize(type:, percent: 0.00, min_spend_limit: 0.00)
    @type = type
    @percent = percent.to_f
    @min_spend_limit = min_spend_limit.to_f
  end
end
