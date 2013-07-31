require 'spec_helper'

describe "Person" do
  before :each do
    @bob = create(:person, last_name: "Bob", dev_serial: "111")
    @don = create(:person, last_name: "Don", dev_serial: "222")
    @bob_upload_1 = create(:upload, total_steps: 10, total_aerobic_steps: 15, calories: 20, distance: 25, person: @bob)
    @bob_upload_2 = create(:upload, total_steps: 10, total_aerobic_steps: 15, calories: 20, distance: 25, person: @bob)
  end


  context "search results" do
    it "returns correct last names" do
      expect(Person.with_last_name("Bob")).to match_array [@bob]
    end

    it "returns correct serial numbers" do
      expect(Person.with_dev_serial('111')).to match_array [@bob]
    end
  end

  context "month stats" do
    it "returns steps for month" do
      expect(@bob.month_stats(Date.current)[:steps]).to eq(20)
    end
    it "returns aerobic steps for month" do
      expect(@bob.month_stats(Date.current)[:aerobic_steps]).to eq(30)
    end
    it "returns calories for month" do
      expect(@bob.month_stats(Date.current)[:calories]).to eq(40)
    end
    it "returns distance for month" do
      expect(@bob.month_stats(Date.current)[:distance]).to eq(50)
    end
  end
end
