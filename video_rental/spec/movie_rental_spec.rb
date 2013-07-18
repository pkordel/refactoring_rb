require "minitest/autorun"
require "ostruct"
require_relative "../customer"

describe Customer do
  subject      { Customer.new("Bob") }
  let(:rental) { Object.new }

  describe "structure" do
    it "supports reading and writing a name attribute" do
      subject.name.must_equal "Bob"
    end

    it "has an empty list of rentals" do
      subject.rentals.must_be_empty
    end
  end

  describe ".add_rental" do
    it "supports adding rentals" do
      subject.add_rental rental
      subject.rentals.must_equal [rental]
    end
  end

end
