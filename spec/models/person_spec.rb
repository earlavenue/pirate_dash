require 'spec_helper'

describe "Person" do
    context "Last Name Searches" do

            it "should return only searched last names when using search_last_name_results" do
                bob = create(:person, :last_name => "Bob")
                don = create(:person, :last_name => "Don")
                all_people = [bob, don]
                correct_search = [bob]
                Person.search_last_name_results("Bob").should eq(correct_search)

            end

    end


end