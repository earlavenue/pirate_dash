require 'spec_helper'

describe Membership do

  context "associations" do
    it { should belong_to(:person) }
    it { should belong_to(:organization) }
  end

  context "validations - shoulda syntax" do
    it { should validate_presence_of(:person_id) }
    it { should validate_presence_of(:organization_id) }
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


end
