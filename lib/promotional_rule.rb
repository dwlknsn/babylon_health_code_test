class PromotionalRule
  attr_reader :percent

  def initialize(type:, percent:)
    @type = type
    @percent = percent.to_f || 0.00
  end
end
