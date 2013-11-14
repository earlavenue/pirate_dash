require 'spec_helper'

describe PersonQuarter do
  before :each do
    @mancow1 = create(:person_quarter, person_id: 1, start_date: "2012-01-01".to_date, active: true, previous_quarter: nil)
    @mancow2 = create(:person_quarter, person_id: 1, start_date: "2012-04-01".to_date, active: true, previous_quarter: true)
    @mancow3 = create(:person_quarter, person_id: 1, start_date: "2012-07-01".to_date, active: false, previous_quarter: true)
    @mancow4 = create(:person_quarter, person_id: 1, start_date: "2012-10-01".to_date, active: false, previous_quarter: false)
    @portisbrain1 =create(:person_quarter, person_id: 2, start_date: "2012-01-01".to_date, active: false, previous_quarter: nil)
    @portisbrain2 =create(:person_quarter, person_id: 2, start_date: "2012-04-01".to_date, active: true, previous_quarter: false)
    @portisbrain3 =create(:person_quarter, person_id: 2, start_date: "2012-07-01".to_date, active: false, previous_quarter: true)
  end


  context "scoping" do
    it "returns active users for a date" do
      expect(PersonQuarter.active_users("2012-01-01".to_date)).to match_array [@mancow1]
    end

    it "returns users gains for a date" do
      expect(PersonQuarter.users_gained("2012-04-01".to_date)).to match_array [@portisbrain2]
    end

    it "returns users lost for a date" do
      expect(PersonQuarter.users_lost("2012-07-01".to_date)).to match_array [@portisbrain3, @mancow3]
    end
  end

  context "create_quarter_record" do
    it "creates a new person quarter" do
      expect{
        PersonQuarter.create_quarter_record(1, Time.now.to_date)
      }.to change(PersonQuarter, :count).by(1)
    end
  end
end
