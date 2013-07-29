require 'spec_helper'

describe "Person" do
    context "Last Name Searches" do


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

      it "returns a hash with monthly stats when using month_stats"

    end


end