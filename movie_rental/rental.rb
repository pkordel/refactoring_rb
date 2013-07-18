class Rental
  attr_reader   :movie
  attr_accessor :days_rented

  def initialize(movie: nil, days_rented: 0)
    @movie       = movie
    @days_rented = days_rented
  end

  def calculate_amount_due
    movie.calculate_amount_due(days_rented)
  end

  def calculate_frequent_renter_points
    movie.calculate_frequent_renter_points(days_rented)
  end
end
