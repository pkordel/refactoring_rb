require "minitest/autorun"
require "ostruct"
require "debugger"
require_relative "../customer"
require_relative "../movie"

describe Customer do
  subject { Customer.new("Bob") }

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
      let(:regular_movie) {
        Movie.new(title: "Days of Thunder", price_code: Movie::REGULAR)
      }
      let(:rental) { OpenStruct.new(movie: regular_movie, days_rented: 1) }
      before { subject.add_rental rental }

      it "calculates correctly for 1 day" do
        subject.statement.must_match /Amount owed is 2/
        subject.statement.must_match /You earned 1 frequent renter points/
      end

      it "calculates correctly for more then 2 days" do
        rental.days_rented = 3
        subject.statement.must_match /Amount owed is 3.5/
        subject.statement.must_match /You earned 1 frequent renter points/
      end
    end

    describe "new release" do
      let(:new_release) {
        Movie.new(title: "Days of Thunder", price_code: Movie::NEW_RELEASE)
      }
      let(:rental) { OpenStruct.new(movie: new_release, days_rented: 1) }
      before { subject.add_rental rental }

      it "calculates correctly for 1 day" do
        subject.statement.must_match /Amount owed is 3/
        subject.statement.must_match /You earned 1 frequent renter points/
      end

      it "calculates correctly for 2 days" do
        rental.days_rented = 2
        subject.statement.must_match /Amount owed is 6/
        subject.statement.must_match /You earned 2 frequent renter points/
      end
    end

    describe "children's movie" do
      let(:childrens_movie) {
        Movie.new(title: "Days of Thunder", price_code: Movie::CHILDRENS)
      }
      let(:rental) { OpenStruct.new(movie: childrens_movie, days_rented: 1) }
      before { subject.add_rental rental }

      it "calculates correctly for less than 3 days" do
        subject.statement.must_match /Amount owed is 1.5/
        subject.statement.must_match /You earned 1 frequent renter points/
      end

      it "calculates correctly for more then 3 days" do
        rental.days_rented = 4
        subject.statement.must_match /Amount owed is 3/
        subject.statement.must_match /You earned 1 frequent renter points/
      end
    end

  end

end
