class Rental
  attr_reader   :movie
  attr_accessor :days_rented

  def initialize(movie: nil, days_rented: 0)
    @movie       = movie
    @days_rented = days_rented
  end

  def calculate_amount_due
    result = 0.0
    case movie.price_code
    when Movie::REGULAR
      result += 2
      if days_rented > 2
        result += (days_rented - 2) * 1.5
      end
    when Movie::NEW_RELEASE
      result += days_rented * 3
    when Movie::CHILDRENS
      result += 1.5
      if days_rented > 3
        result += (days_rented - 3) * 1.5
      end
    end
    result
  end

  def calculate_frequent_renter_points
    # Add bonus for a two day new release
    if movie.price_code == Movie::NEW_RELEASE && days_rented > 1
      2
    else
      1
    end
  end
end
