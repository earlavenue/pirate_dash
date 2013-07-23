require 'spec_helper'

describe Person do

  context 'that has two uploads' do
    subject(:person) { Person.create(
      first_name: 'James',
      last_name: 'Joyce',
      email: 'jj@example.com',
      dev_serial: 'HJ72072648',
      organization_id: 1
      )}
    Upload.create(
      upload_time: Date.current,
      dev_serial: 'HJ72072648',
      person_id: 1,
      total_steps: 50,
      total_aerobic_steps: 10,
      calories: 100,
      distance: 2
      )
    Upload.create(
      upload_time: Date.current,
      dev_serial: 'HJ72072648',
      person_id: 1,
      total_steps: 50,
      total_aerobic_steps: 10,
      calories: 100,
      distance: 2
      )

    its(:lifetime_steps) { should == 100 }

  end

end
