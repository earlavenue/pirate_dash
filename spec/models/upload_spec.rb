require 'spec_helper'

describe Upload do
  context "Non-Pirate Upload Work" do
    before :each do
      @ww = create(:person, first_name: "Walter", last_name: "White")
      @ww_upload_1 = create(:upload, total_steps: 10, aerobic_steps: 15, calories: 20, distance: 25, person: @ww)
      @ww_upload_2 = create(:upload, total_steps: 100, aerobic_steps: 150, calories: 200, distance: 250, person: @ww)
    end

    context "scoping" do
      it "returns uploads from within the specified date range" do
        other_month_upload = create(:upload, total_steps: 2, aerobic_steps: 4, calories: 6, distance: 8, person: @ww, date: Time.zone.now - 2.months)
        expect(Upload.within_date_range(Time.zone.now - 1.month, Time.zone.now + 1.day)).to include(@ww_upload_1, @ww_upload_2)
      end

      it "doesn't return uploads from outside the date range" do
        other_month_upload = create(:upload, total_steps: 2, aerobic_steps: 4, calories: 6, distance: 8, person: @ww, date: Time.zone.now - 2.months)
        expect(Upload.within_date_range(Time.zone.now - 1.month, Time.zone.now + 1.day)).to_not include(other_month_upload)
      end

      it "only returns uploads belonging to the specified person" do
        pinkman = create(:person, first_name: "Jesse", last_name: "Pinkman")
        jp_upload = create(:upload, person: pinkman)
        expect(Upload.belonging_to_person(@ww)).to_not include(jp_upload)
      end
    end


    context "reporting statistics" do
      it "returns total steps" do
        expect(Upload.month_stats(@ww.uploads)[:steps]).to eq(110)
      end

      it "returns total aerobic steps" do
        expect(Upload.month_stats(@ww.uploads)[:aerobic_steps]).to eq(165)
      end

      it "returns total calories" do
        expect(Upload.month_stats(@ww.uploads)[:calories]).to eq(220)
      end

      it "returns total distance" do
        expect(Upload.month_stats(@ww.uploads)[:distance]).to eq(275)
      end

      it "returns a blank month_stats hash if there are no uploads for a month" do
        empty_month = []
        expect(Upload.month_stats(empty_month)).to eq({steps: 0, aerobic_steps: 0, calories: 0, distance: 0})
      end
    end
  end

  context "Pirate Upload Work" do
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
          expect(Upload.current_quarter_activations("HJ-720", "2013-07-01".to_date)).to eq(1)
      end

      it "returns the correct total for HJAs uploaded Q3 by model" do
          expect(Upload.current_quarter_activations("HJA-312", "2013-07-01".to_date)).to eq(1)
      end

      it "returns the correct total for HJAs uploaded Q1 by model" do
          expect(Upload.current_quarter_activations("HJA-312", "2013-01-01".to_date)).to eq(1)
      end

      it "returns the correct total for HJ720s uploaded by model" do
          expect(Upload.current_quarter_activations("HJ-322", "2013-04-01".to_date)).to eq(2)
      end

      it "accepts nil device_serials" do
          expect(Upload.current_quarter_activations("HJ-322", "2013-10-01".to_date)).to eq(1)
      end
    end

    context "Discrete Month Activations" do

      it "returns distinct first uploads for 2013-06" do
          expect(Upload.discrete_month_activations(2013)).to eq([[1,0],[2,2],[3,0],[4,0],[5,1],[6,0],[7,0],[8,0],[9,0],[10,0],[11,0],[12,0],[13,0]])
      end
    end
  end
end
