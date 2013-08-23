require 'spec_helper'

describe Upload do
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
