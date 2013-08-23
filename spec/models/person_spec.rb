require 'spec_helper'

describe "Person" do
  before :each do
    @zebra = create(:organization, name: "Zebra Industries")
    @aardvark = create(:organization, name: "Aardvark Corporation")
    @bob = create(:person, last_name: "Bob", organization: @zebra)
    @don = create(:person, last_name: "Don", organization: @aardvark)
    @bob_upload_1 = create(:upload, total_steps: 10, aerobic_steps: 15, calories: 20, distance: 25, person: @bob)
    @bob_upload_2 = create(:upload, total_steps: 10, aerobic_steps: 15, calories: 20, distance: 25, person: @bob)
  end


  context "scoping" do
    it "orders by organization name" do
      expect(Person.order_by_organization).to start_with(@don)
    end

    it "returns correct organization members" do
      expect(Person.from_organization(@zebra.id)).to match_array [@bob]
    end

    it "does not return other organization members" do
      expect(Person.from_organization(@zebra.id)).to_not include(@don)
    end

    it "returns correct last names" do
      expect(Person.with_last_name("Bob")).to match_array [@bob]
    end

    it "does not return an incorrect last name" do
      expect(Person.with_last_name("Bob")).to_not include(@don)
    end
  end
end
