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
end
