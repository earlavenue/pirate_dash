raise "Can't run in #{Rails.env}" unless Rails.env.development?

Organization.destroy_all
Organization.create({
  name: 'Rush Hospital',
  address: 'West Loop Somewhere',
  city: 'Chicago',
  state: 'IL',
  zip: '60101'
  })
Organization.create({
  name: 'General',
  address: 'N/A',
  city: 'N/A',
  state: 'N/A',
  zip: 'N/A'
  })
Organization.create({
  name: 'Omron Fitness',
  address: "Zach's Apartment",
  city: "Chicago",
  state: "IL",
  zip: "60556"
  })
puts 'Three organizations created: Rush Hospital, Omron Fitness, and "General".'

Client.destroy_all
Client.create(
    {email: 'flash@example.com',
    first_name: 'Flash',
    last_name: 'Gordon',
    password: '12345',
    password_confirmation: '12345',
    organization_id: Organization.find_by_name("Rush Hospital").id})

Client.create(
    {email: 'zach@example.com',
    first_name: 'Zach',
    last_name: 'Albright',
    password: '12345',
    password_confirmation: '12345',
    organization_id: Organization.find_by_name("Omron Fitness").id})
puts "Two clients created: Flash Gordon from Rush Hospital and Zach Albright from Omron Fitness. Log in with [first_name]@example.com / 12345."
