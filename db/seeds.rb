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
  name: 'Northwestern Hospital',
  address: 'Evanston Somewhere',
  city: 'Evanston',
  state: 'IL',
  zip: '60089'
  })
Organization.create({
  name: 'Omron Fitness',
  address: "Zach's Apartment",
  city: "Chicago",
  state: "IL",
  zip: "60556"
  })
puts 'Three organizations created: Rush Hospital, Northwestern Hospital, and Omron Fitness.'

Client.destroy_all
Client.create(
    {email: 'flash@example.com',
    first_name: 'Flash',
    last_name: 'Gordon',
    password: '12345',
    password_confirmation: '12345',
    organization_id: Organization.find_by_name("Rush Hospital").id})

Client.create(
    {email: 'clark@example.com',
    first_name: 'Clark',
    last_name: 'Kent',
    password: '12345',
    password_confirmation: '12345',
    organization_id: Organization.find_by_name("Northwestern Hospital").id})

Client.create(
    {email: 'zach@example.com',
    first_name: 'Zach',
    last_name: 'Albright',
    password: '12345',
    password_confirmation: '12345',
    organization_id: Organization.find_by_name("Omron Fitness").id})

puts 'Three user accounts created.'
puts 'To log in as Rush Hospital HR manager Flash Gordon, use these credentials:'
puts 'email: flash@example.com'
puts 'password: 12345'
puts ''
puts 'To log in as Northwestern Hospital rep Clark Kent, use these credentials:'
puts 'email: clark@example.com'
puts 'password: 12345'
puts 'To log in as Omron Fitness master of all things Zach Albright, use these credentials:'
puts 'email: zach@example.com'
puts 'password: 12345'
puts ''
puts 'Only Omron Fitness users can import People and Uploads. Currently, use the Walking Report CSV for both.'
