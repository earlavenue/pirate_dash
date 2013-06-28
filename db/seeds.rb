# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@user = User.new
@user.email = 'pirate@example.com'
@user.password = '12345'
@user.password_confirmation = '12345'
@user.save
puts 'Log in as "pirate":'
puts 'email: "pirate@example.com"'
puts 'password: "12345"'
puts ''
puts 'If you are importing people from KISSmetrics, make sure the csv has only two columns: "km_userid" and "pedserial".'
