class Movie
  attr_reader :title, :price_code

  REGULAR     = 1
  NEW_RELEASE = 2
  CHILDRENS   = 3

  def initialize(title: "", price_code: 0)
    @title, @price_code = title, price_code
  end

  def calculate_amount_due(days_rented)
    result = 0.0
    case price_code
    when Movie::REGULAR
      result += 2
      result += (days_rented - 2) * 1.5 if days_rented > 2
    when Movie::NEW_RELEASE
      result += days_rented * 3
    when Movie::CHILDRENS
      result += 1.5
      result += (days_rented - 3) * 1.5 if days_rented > 3
    end
    result
  end

  def calculate_frequent_renter_points(days_rented)
    # Add bonus for a two day new release
    if price_code == Movie::NEW_RELEASE && days_rented > 1
      2
    else
      1
    end
  end
end
