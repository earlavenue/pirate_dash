require 'spec_helper'

describe "Person" do
  context "search results" do
    it "returns correct last names" do
      bob = create(:person, :last_name => "Bob")
      don = create(:person, :last_name => "Don")
      correct_search = [bob]
      Person.search_last_name_results("Bob").should eq(correct_search)
    end

    it "returns correct serial numbers" do
      bob = create(:person, :dev_serial => '111')
      don = create(:person, :dev_serial => '222')
      correct_search = [bob]
      Person.search_serial_results('111').should eq(correct_search)
    end
  end

  context "month stats" do
    it "returns steps for month" do
      person = create(:person)
      upload_1 = create(:upload, total_steps: 10, person: person)
      upload_2 = create(:upload, total_steps: 10, person: person)
      expect(person.month_stats(person.uploads, Date.current)[:steps]).to eq(20)
    end
    it "returns aerobic steps for month" do
      person = create(:person)
      upload_1 = create(:upload, total_aerobic_steps: 10, person: person)
      upload_2 = create(:upload, total_aerobic_steps: 10, person: person)
      expect(person.month_stats(person.uploads, Date.current)[:aerobic_steps]).to eq(20)
    end
    it "returns calories for month" do
      person = create(:person)
      upload_1 = create(:upload, calories: 10, person: person)
      upload_2 = create(:upload, calories: 10, person: person)
      expect(person.month_stats(person.uploads, Date.current)[:calories]).to eq(20)
    end
    it "returns distance for month" do
      person = create(:person)
      upload_1 = create(:upload, distance: 10, person: person)
      upload_2 = create(:upload, distance: 10, person: person)
      expect(person.month_stats(person.uploads, Date.current)[:distance]).to eq(20)
    end
  end
end
