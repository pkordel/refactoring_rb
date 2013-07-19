require "minitest/autorun"
require "ostruct"
require "debugger"
require_relative "../customer"
require_relative "../movie"
require_relative "../rental"

describe Customer do
  subject { Customer.new("Bob") }
  let(:regular_movie)   { Movie.new(title: "Days of Thunder",
                                    price: RegularPrice.new) }
  let(:new_release)     { Movie.new(title: "Days of Thunder",
                                    price: NewReleasePrice.new) }
  let(:childrens_movie) { Movie.new(title: "Days of Thunder",
                                    price: ChildrensPrice.new) }

  describe "structure" do
    it "supports reading and writing a name attribute" do
      subject.name.must_equal "Bob"
    end

    it "has an empty list of rentals" do
      subject.rentals.must_be_empty
    end
  end

  describe ".add_rental" do
    let(:rental) { Object.new }

    it "supports adding rentals" do
      subject.add_rental rental
      subject.rentals.must_equal [rental]
    end
  end

  describe ".statement" do

    describe "regular movie" do
      let(:rental) { Rental.new(movie: regular_movie, days_rented: 1) }
      before { subject.add_rental rental }

      it "calculates correctly for 1 day" do
        subject.statement.must_match /Amount owed is 2.0/
        subject.statement.must_match /You earned 1 frequent renter points/
      end

      it "calculates correctly for more then 2 days" do
        rental.days_rented = 3
        subject.statement.must_match /Amount owed is 3.5/
        subject.statement.must_match /You earned 1 frequent renter points/
      end
    end

    describe "new release" do
      let(:rental) { Rental.new(movie: new_release, days_rented: 1) }
      before { subject.add_rental rental }

      it "calculates correctly for 1 day" do
        subject.statement.must_match /Amount owed is 3.0/
        subject.statement.must_match /You earned 1 frequent renter points/
      end

      it "calculates correctly for 2 days" do
        rental.days_rented = 2
        subject.statement.must_match /Amount owed is 6.0/
        subject.statement.must_match /You earned 2 frequent renter points/
      end
    end

    describe "children's movie" do
      let(:rental) { Rental.new(movie: childrens_movie, days_rented: 1) }
      before { subject.add_rental rental }

      it "calculates correctly for less than 3 days" do
        subject.statement.must_match /Amount owed is 1.5/
        subject.statement.must_match /You earned 1 frequent renter points/
      end

      it "calculates correctly for more then 3 days" do
        rental.days_rented = 4
        subject.statement.must_match /Amount owed is 3.0/
        subject.statement.must_match /You earned 1 frequent renter points/
      end
    end
  end

  describe ".html_statement" do

    describe "regular movie" do
      let(:rental) { Rental.new(movie: regular_movie, days_rented: 1) }
      before { subject.add_rental rental }

      it "calculates correctly for 1 day" do
        subject.html_statement.must_match(/You owe <em>2.0<\/em>/)
        subject.html_statement.must_match(/<em>1<\/em> frequent renter points/)
      end

      it "calculates correctly for more then 2 days" do
        rental.days_rented = 3
        subject.html_statement.must_match(/You owe <em>3.5<\/em>/)
        subject.html_statement.must_match(/<em>1<\/em> frequent renter points/)
      end
    end

    describe "new release" do
      let(:rental) { Rental.new(movie: new_release, days_rented: 1) }
      before { subject.add_rental rental }

      it "calculates correctly for 1 day" do
        subject.html_statement.must_match(/You owe <em>3.0<\/em>/)
        subject.html_statement.must_match(/<em>1<\/em> frequent renter points/)
      end

      it "calculates correctly for 2 days" do
        rental.days_rented = 2
        subject.html_statement.must_match(/You owe <em>6.0<\/em>/)
        subject.html_statement.must_match(/<em>2<\/em> frequent renter points/)
      end
    end

    describe "children's movie" do
      let(:rental) { Rental.new(movie: childrens_movie, days_rented: 1) }
      before { subject.add_rental rental }

      it "calculates correctly for less than 3 days" do
        subject.html_statement.must_match(/You owe <em>1.5<\/em>/)
        subject.html_statement.must_match(/<em>1<\/em> frequent renter points/)
      end

      it "calculates correctly for more then 3 days" do
        rental.days_rented = 4
        subject.html_statement.must_match(/You owe <em>3.0<\/em>/)
        subject.html_statement.must_match(/<em>1<\/em> frequent renter points/)
      end
    end
  end

end
