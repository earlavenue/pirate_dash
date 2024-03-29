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
    password_confirmation: '12345'})

puts 'Log in as Edward Teach with these credentials:'
puts 'email: "pirate@example.com"'
puts 'password: "12345"'
puts ''


Person.destroy_all
Person.create(
    {dev_serial: 'HJ72026025380',
    km_userid: '700',
    omron_userid: '86301',
    first_name: "Luke",
    last_name: "Skywalker",
    email: "luke@example.com",
    gender: "male",
    city: "Tatooine",
    state: "KS",
    country: "USA"})
Person.create(
    {dev_serial: 'HJ72026071490',
    km_userid: '1002',
    omron_userid: '552',
    first_name: "Andrew",
    last_name: "Wiggin",
    email: "andrew@example.com",
    gender: "male",
    city: "Milagre",
    state: "FL",
    country: "USA"})
Person.create(
    {dev_serial: 'HJ72025088790',
    km_userid: '1012',
    omron_userid: '1985',
    first_name: "Marty",
    last_name: "McFly",
    email: "marty@example.com",
    gender: "male",
    city: "Hill Valley",
    state: "CA",
    country: "USA"})
Person.create(
    {dev_serial: 'HJ72027007820',
    km_userid: '1075',
    omron_userid: '1998',
    first_name: "Michael",
    last_name: "Jordan",
    email: "michael@example.com",
    gender: "male",
    city: "Chicago",
    state: "IL",
    country: "USA"})
Person.create(
    {dev_serial: 'HJ72012066850',
    km_userid: '1077',
    omron_userid: '1929084',
    first_name: "Audrey",
    last_name: "Hepburn",
    email: "audrey@example.com",
    gender: "female",
    city: "Los Angeles",
    state: "CA",
    country: "USA"})
Person.create(
    {dev_serial: 'HJ72026109690',
    km_userid: '1123',
    omron_userid: '628200',
    first_name: "Miles",
    last_name: "Davis",
    email: "miles@example.com",
    gender: "male",
    city: "St. Louis",
    state: "MO",
    country: "USA"})

puts 'Six people created'
puts 'Currently, importing people from KISSmetrics only supports two columns. Make sure the csv only includes "km_userid" and "dev_serial".'
puts ''

Client.create(
    {email: 'zach@example.com',
    first_name: 'Zach',
    last_name: 'Albright',
    password: '12345',
    password_confirmation: '12345',
    organization_id: Organization.find_by_name("Omron Fitness").id})
puts "Two clients created: Flash Gordon from Rush Hospital and Zach Albright from Omron Fitness. Log in with [first_name]@example.com / 12345."
