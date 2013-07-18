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
      amount = 0
      # Determine amounts for each line
      case rental.movie.price_code
      when Movie::REGULAR
        amount += 2
        if rental.days_rented > 2
          amount += (rental.days_rented - 2) * 1.5
        end
      when Movie::NEW_RELEASE
        amount += rental.days_rented * 3
      when Movie::CHILDRENS
        amount += 1.5
        if rental.days_rented > 3
          amount += (rental.days_rented - 3) * 1.5
        end
      end

      # Add frequent renter points
      frequent_renter_points += 1
      # Add bonus for a two day new release
      if rental.movie.price_code == Movie::NEW_RELEASE &&
        rental.days_rented > 1
        frequent_renter_points += 1
      end

      # Show figures for this rental
      result << "\t#{rental.movie.title}\t#{amount}\n"
      total_amount += amount
    end

    # Add footer lines
    result << "Amount owed is #{total_amount}\n"
    result << "You earned #{frequent_renter_points} frequent renter points"
    result
  end
end
