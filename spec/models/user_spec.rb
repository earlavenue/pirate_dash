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

  context 'that already exists' do

  end
end
