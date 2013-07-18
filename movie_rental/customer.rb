class Customer
  attr_reader :name, :rentals

  def initialize(name = "")
    @name    = name
    @rentals = Array.new
  end

  def add_rental rental
    rentals << rental
  end

  def statement
    result = "Rental Record for #{name}\n"

    rentals.each do |rental|
      # Show figures for this rental
      result << "\t#{rental.movie.title}\t#{rental.calculate_amount_due}\n"
    end

    # Add footer lines
    result << "Amount owed is #{calculate_total_charge}\n"
    result << "You earned #{calculate_total_frequent_renter_points} frequent renter points"
    result
  end

  def calculate_total_charge
    rentals.map(&:calculate_amount_due).inject(&:+)
  end

  def calculate_total_frequent_renter_points
    rentals.map(&:calculate_frequent_renter_points).inject(&:+)
  end
end
