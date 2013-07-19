require_relative "default_price"

class RegularPrice
  include DefaultPrice

  def calculate_amount_due(days_rented)
    result = 2.0
    result += (days_rented - 2) * 1.5 if days_rented > 2
    result
  end
end
