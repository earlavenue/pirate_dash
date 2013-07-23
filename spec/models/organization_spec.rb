require "spec_helper.rb"

describe Organization do

    subject(:organization) { Organization.create(name: "The Boom Factory",
      address: "Where the Party Is",
      city: "Chi-town",
      state: "Illinoise",
      zip: "666") }


 its (:full_address) {should == "Where the Party Is, Chi-town, Illinoise, 666"}

end

    # t.string   "name"
    # t.string   "address"
    # t.string   "city"
    # t.string   "state"
    # t.string   "zip"
    # t.datetime "created_at", :null => false
    # t.datetime "updated_at", :null => false