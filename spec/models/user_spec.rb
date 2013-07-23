require 'spec_helper'

describe User do
  context 'that is new' do
    subject(:user) { User.create(
      first_name: 'Pablo',
      last_name: 'Picasso',
      email: 'pablo@example.com',
      organization_id: 1
      )}

    Organization.create(
      name: 'Spanish Dudes',
      address: '7019 Clayton Ct.',
      city: 'Downers Grove',
      state: 'IL',
      zip: '60516'
      )

    its(:first_name) { should == 'Pablo' }
    it 'should be a Spanish Dude' do
      subject.organization.name.should == "Spanish Dudes"
    end
  end

  context "Password Testing" do
    it "authenticates with matching username and password" do
      #organization = build(:organization)
      user = create(:user, first_name: "batman", password: "secret")
      user.authenticate("secret").should be_true#eq(user)
    end

    it "does not authenticate with incorrect password" do
      #organization = build(:organization)
      user = create(:user, first_name: "batman", password: "secret")
      user.authenticate("incorrect").should be_false
    end
  end

end
