class Movie
  attr_reader :title, :price_code

  REGULAR     = 1
  NEW_RELEASE = 2
  CHILDRENS   = 3

  def initialize(title: "", price_code: 0)
    @title, @price_code = title, price_code
  end
end
