require 'spec_helper'

describe Pirate do
  before :each do
    @jc = create(:person, first_name: "Jeff", last_name: "Cohen")
    @rb = create(:person, first_name: "Raghu", last_name: "Betina")
    @mm = create(:person, first_name: "Michael", last_name: "McGee")

    @HJ721 = create(:upload, date: "2013-08-01".to_date, device_serial: "222", device_model: "HJ-720", person: @jc)
    @HJ722 = create(:upload, date: "2013-11-01".to_date, device_serial: "111", device_model: "HJ-720", person: @jc)
    @HJ723 = create(:upload, date: "2013-08-10".to_date, device_serial: "111", device_model: "HJ-720", person: @jc)
    @HJ724 = create(:upload, date: "2013-01-03".to_date, device_serial: "222", device_model: "HJ-720", person: @jc)

    @HJA1 = create(:upload, date: "2013-01-03".to_date, device_serial: "555", device_model: "HJA-312", person: @rb)
    @HJA2 = create(:upload, date: "2013-08-10".to_date, device_serial: "444", device_model: "HJA-312", person: @jc)
    @HJA3 = create(:upload, date: "2013-09-10".to_date, device_serial: "555", device_model: "HJA-312", person: @rb)

    @HJ3221 = create(:upload, date: "2013-06-06".to_date, device_serial: "777", device_model: "HJ-322", person: @mm)
    @HJ3222 = create(:upload, date: "2013-06-01".to_date, device_serial: "777", device_model: "HJ-322", person: @mm)
    @HJ3223 = create(:upload, date: "2013-04-01".to_date, device_serial: "888", device_model: "HJ-322", person: @mm)

    @nil1 = create(:upload, date: "2013-11-01".to_date, device_serial: nil, device_model: "HJ-322", person: @rb)
    @nil2 = create(:upload, date: "2013-11-10".to_date, device_serial: "000", device_model: nil, person: @rb)
  end

  context "Device Activations" do
    it "returns the correct total for HJ720s uploaded by model" do
        expect(Pirate.current_quarter_activations("HJ-720", "2013-07-01".to_date)).to eq(1)
    end

    it "returns the correct total for HJAs uploaded Q3 by model" do
        expect(Pirate.current_quarter_activations("HJA-312", "2013-07-01".to_date)).to eq(1)
    end

    it "returns the correct total for HJAs uploaded Q1 by model" do
        expect(Pirate.current_quarter_activations("HJA-312", "2013-01-01".to_date)).to eq(1)
    end

    it "returns the correct total for HJ720s uploaded by model" do
        expect(Pirate.current_quarter_activations("HJ-322", "2013-04-01".to_date)).to eq(2)
    end

    it "accepts nil device_serials" do
        expect(Pirate.current_quarter_activations("HJ-322", "2013-10-01".to_date)).to eq(1)
    end
  end

  context "Discrete Month Activations" do

    it "returns distinct first uploads for 2013-06" do
        expect(Pirate.discrete_month_activations(2013)).to eq([[1,0],[2,2],[3,0],[4,0],[5,1],[6,0],[7,0],[8,0],[9,0],[10,0],[11,0],[12,0],[13,0]])
    end
  end

end
