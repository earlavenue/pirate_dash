require 'spec_helper'

describe Pirate do
  before :each do
    @HJ721 = create(:upload, date: "2013-08-01".to_date, device_serial: "222", device_model: "HJ-720")
    @HJ722 = create(:upload, date: "2013-11-01".to_date, device_serial: "111", device_model: "HJ-720")
    @HJ723 = create(:upload, date: "2013-08-10".to_date, device_serial: "111", device_model: "HJ-720")
    @HJ724 = create(:upload, date: "2013-01-03", device_serial: "222", device_model: "HJ-720")

    @HJA1 = create(:upload, date: "2013-01-03".to_date, device_serial: "555", device_model: "HJA-312")
    @HJA2 = create(:upload, date: "2013-08-10".to_date, device_serial: "444", device_model: "HJA-312")
    @HJA3 = create(:upload, date: "2013-09-10".to_date, device_serial: "555", device_model: "HJA-312")

    @HJ3221 = create(:upload, date: "2013-06-06".to_date, device_serial: "777", device_model: "HJ-322")
    @HJ3222 = create(:upload, date: "2013-06-01".to_date, device_serial: "777", device_model: "HJ-322")
    @HJ3223 = create(:upload, date: "2013-04-01".to_date, device_serial: "888", device_model: "HJ-322")

    @nil1 = create(:upload, date: "2013-11-01".to_date, device_serial: nil, device_model: "HJ-322")
    @nil2 = create(:upload, date: "2013-11-10".to_date, device_serial: "000", device_model: nil)
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
end