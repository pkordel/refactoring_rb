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
    total_amount           = 0
    frequent_renter_points = 0
    result                 = "Rental Record for #{name}\n"

    rentals.each do |rental|
      frequent_renter_points += rental.calculate_frequent_renter_points

      # Show figures for this rental
      result << "\t#{rental.movie.title}\t#{rental.calculate_amount_due}\n"
      total_amount += rental.calculate_amount_due
    end

    # Add footer lines
    result << "Amount owed is #{total_amount}\n"
    result << "You earned #{frequent_renter_points} frequent renter points"
    result
  end
end
