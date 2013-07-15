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

User.destroy_all
User.create(
    {email: 'flash@example.com',
    first_name: 'Flash',
    last_name: 'Gordon',
    password: '12345',
    password_confirmation: '12345',
    organization_id: Organization.find_by_name("Rush Hospital").id})

User.create(
    {email: 'clark@example.com',
    first_name: 'Clark',
    last_name: 'Kent',
    password: '12345',
    password_confirmation: '12345',
    organization_id: Organization.find_by_name("Northwestern Hospital").id})

User.create(
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

Person.destroy_all
Upload.destroy_all
Person.create({
    first_name: 'Keith',
    last_name: 'Jarrett',
    email: 'keith@example.com',
    dev_serial: 'HJ819378',
    organization_id: Organization.find_by_name("Northwestern Hospital").id})
Person.create({
    first_name: 'Miles',
    last_name: 'Davis',
    email: 'miles@example.com',
    dev_serial: 'HJ51630294',
    organization_id: Organization.find_by_name("Northwestern Hospital").id})

puts 'Two people from Northwestern Hospital, Keith Jarrett and Miles Davis, have been created. All other people and uploads have been deleted. Log in as Flash Gordon and import people and uploads using the Walking Report csv. Be sure to perform these actions as Flash Gordon, NOT as Zach Albright.'
