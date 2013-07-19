require_relative "default_price"

class NewReleasePrice
  include DefaultPrice

  def calculate_frequent_renter_points(days_rented)
    days_rented > 1 ? 2 : 1
  end

  def calculate_amount_due(days_rented)
    days_rented * 3.0
  end
end
