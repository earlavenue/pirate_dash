require 'spec_helper'

describe Membership do

  context "associations" do
    it { should belong_to(:person) }
    it { should belong_to(:organization) }
  end

  context "validations - shoulda syntax" do
    it { should validate_presence_of(:person_id) }
    it { should validate_presence_of(:organization_id) }
    it { should validate_uniqueness_of(:person_id) }
  end

  context "validations - rspec syntax" do
    it "must have a person_id" do
      membership = build(:membership, person_id: nil)
      expect(membership).to have(1).errors_on(:person_id)
    end

    it "must have an organization_id" do
      membership = build(:membership, organization_id: nil)
      expect(membership).to have(1).errors_on(:organization_id)
    end
  end

  it "sets a person's upload date" do
    charlie = create(:person)
    membership = create(:membership, person_id: charlie.id)
    first_upload = create(:upload, person: charlie, date: Time.zone.now - 4.months)
    second_upload = create(:upload, person: charlie, date: Time.zone.now - 2.months)
    expect(Membership.set_first_upload_date(charlie)).to eq((Time.zone.now - 4.months).to_date)
  end
end
