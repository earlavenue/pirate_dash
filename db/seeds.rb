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
  name: 'Omron Fitness',
  address: "Zach's Apartment",
  city: "Chicago",
  state: "IL",
  zip: "60556"
  })
puts 'Two organizations created: Rush Hospital and Omron Fitness.'

User.destroy_all
User.create(
    {email: 'flash@example.com',
    first_name: 'Flash',
    last_name: 'Gordon',
    password: '12345',
    password_confirmation: '12345',
    organization_id: Organization.find_by_name("Rush Hospital").id})

User.create(
    {email: 'zach@example.com',
    first_name: 'Zach',
    last_name: 'Albright',
    password: '12345',
    password_confirmation: '12345',
    organization_id: Organization.find_by_name("Omron Fitness").id})

puts 'Two user accounts created.'
puts 'To log in as Rush Hospital HR manager Flash Gordon, use these credentials:'
puts 'email: flash@example.com'
puts 'password: 12345'
puts ''
puts 'To log in as Omron Fitness admin Zach Albright, use these credentials:'
puts 'email: zach@example.com'
puts 'password: 12345'
puts ''

Person.destroy_all
Upload.destroy_all
puts 'All previous people and uploads have been deleted. You need to re-import people and uploads from the Walking Report csv. Be sure to perform these actions as Flash Gordon, NOT as Zach Albright.'

