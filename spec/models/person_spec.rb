require 'spec_helper'

describe "Person" do
  it "should return only searched last names when using search_last_name_results" do
    bob = create(:person, :last_name => "Bob")
    don = create(:person, :last_name => "Don")
    correct_search = [bob]
    Person.search_last_name_results("Bob").should eq(correct_search)
  end

  it "should only return correct device serial number when using search_serial_results" do
    bob = create(:person, :dev_serial => '111')
    don = create(:person, :dev_serial => '222')
    correct_search = [bob]
    Person.search_serial_results('111').should eq(correct_search)
  end

  context "month stats" do
    it "has month total_steps" do
      person = create(:person)
      upload_1 = create(:upload, total_steps: 10, person: person)
      upload_2 = create(:upload, total_steps: 10, person: person)
      expect(person.month_stats(person.uploads, Date.current)[:steps]).to eq(20)
    end
    it "has month total_aerobic_steps" do
      person = create(:person)
      upload_1 = create(:upload, total_aerobic_steps: 10, person: person)
      upload_2 = create(:upload, total_aerobic_steps: 10, person: person)
      expect(person.month_stats(person.uploads, Date.current)[:aerobic_steps]).to eq(20)
    end
    it "has month calories" do
      person = create(:person)
      upload_1 = create(:upload, calories: 10, person: person)
      upload_2 = create(:upload, calories: 10, person: person)
      expect(person.month_stats(person.uploads, Date.current)[:calories]).to eq(20)
    end
    it "has month distance" do
      person = create(:person)
      upload_1 = create(:upload, distance: 10, person: person)
      upload_2 = create(:upload, distance: 10, person: person)
      expect(person.month_stats(person.uploads, Date.current)[:distance]).to eq(20)
    end
  end
end
