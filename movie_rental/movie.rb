require_relative "new_release_price"
require_relative "childrens_price"
require_relative "regular_price"

class Movie
  attr_reader :title
  attr_writer :price

  def initialize(title: "", price: nil)
    @title, @price = title, price
  end

  def calculate_amount_due(days_rented)
    @price.calculate_amount_due(days_rented)
  end

  def calculate_frequent_renter_points(days_rented)
    @price.calculate_frequent_renter_points(days_rented)
  end
end
