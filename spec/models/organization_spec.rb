require 'spec_helper'

describe Organization do

  context "associations" do
    it { should have_many(:memberships) }
    it { should have_many(:people).through(:memberships) }
    it { should have_many(:clients) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code) }
  end
end
