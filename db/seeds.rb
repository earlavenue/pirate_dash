# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
@user = User.new
@user.email = 'pirate@example.com'
@user.password = '12345'
@user.password_confirmation = '12345'
@user.save
puts 'Log in as "pirate":'
puts 'email: "pirate@example.com"'
puts 'password: "12345"'
puts ''


Person.destroy_all
Person.create(
    {pedserial: 'HJ72026025380',
    km_userid: '700',
    omron_userid: 86301,
    first_name: "Foo",
    last_name: "Bar",
    email: "foobar@example.com",
    gender: "male",
    city: "Chicago",
    state: "IL",
    country: "USA"})
Person.create(
    {pedserial: 'HJ72026071490',
    km_userid: '1002',
    omron_userid: 552,
    first_name: "Foofoo",
    last_name: "Barbar",
    email: "foofoobarbar@example.com",
    gender: "female",
    city: "San Francisco",
    state: "CA",
    country: "USA"})
Person.create(
    {pedserial: 'HJ72025088790',
    km_userid: '1012',
    omron_userid: 1985,
    first_name: "Marty",
    last_name: "McFly",
    email: "marty@example.com",
    gender: "male",
    city: "Hill Valley",
    state: "CA",
    country: "USA"})
Person.create(
    {pedserial: 'HJ72027007820',
    km_userid: '1075',
    omron_userid: 1998,
    first_name: "Michael",
    last_name: "Jordan",
    email: "mj@example.com",
    gender: "male",
    city: "Chicago",
    state: "IL",
    country: "USA"})
Person.create(
    {pedserial: 'HJ72012066850',
    km_userid: '1077',
    omron_userid: 1929084,
    first_name: "Audrey",
    last_name: "Hepburn",
    email: "audrey@example.com",
    gender: "female",
    city: "Los Angeles",
    state: "CA",
    country: "USA"})
Person.create(
    {pedserial: 'HJ72026109690',
    km_userid: '1123',
    omron_userid: 628200,
    first_name: "Miles",
    last_name: "Davis",
    email: "miles@example.com",
    gender: "male",
    city: "St. Louis",
    state: "MO",
    country: "USA"})

puts 'Six people created'
puts 'Currently, importing people from KISSmetrics only supports two columns. Make sure the csv only includes "km_userid" and "pedserial".'
