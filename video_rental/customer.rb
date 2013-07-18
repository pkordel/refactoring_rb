class Customer
  attr_reader :name, :rentals

  def initialize(name = "")
    @name    = name
    @rentals = Array.new
  end

  def add_rental rental
    rentals << rental
  end
end
