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
puts 'Two people created'
puts 'Currently, importing people from KISSmetrics only supports two columns. Make sure the csv only includes "km_userid" and "pedserial".'
