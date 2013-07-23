describe Person do
  subject(:person) { Person.create(dev_serial: "92882"
    #Add more




    )}
end

   t.string   "dev_serial"
    t.string   "km_userid"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "omron_userid"
    t.integer  "organization_id"
  end