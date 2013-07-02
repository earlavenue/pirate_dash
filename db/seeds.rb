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
    first_name: "Luke",
    last_name: "Skywalker",
    email: "luke@example.com",
    gender: "male",
    city: "Tatooine",
    state: "KS",
    country: "USA"})
Person.create(
    {pedserial: 'HJ72026071490',
    km_userid: '1002',
    omron_userid: 552,
    first_name: "Andrew",
    last_name: "Wiggin",
    email: "andrew@example.com",
    gender: "male",
    city: "Milagre",
    state: "FL",
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
puts ''

Event.destroy_all
Event.create(
    {action: 'dashboard',
    doer: '1123',
    event_time: 1367889160})
Event.create(
    {action: 'page view',
    doer: '1075',
    event_time: 1367890276})
Event.create(
    {action: 'uploaded',
    doer: '1077',
    event_time: 1367890283})
Event.create(
    {action: 'uploaded',
    doer: '1012',
    event_time: 1367890296})
Event.create(
    {action: 'pc driver download',
    doer: '1002',
    event_time: 1367890299})
Event.create(
    {action: 'home page view',
    doer: '700',
    event_time: 1367890339})
Event.create(
    {action: 'page view',
    doer: 'luke@example.com',
    event_time: 1367890349})
Event.create(
    {action: 'uploaded',
    doer: 'andrew@example.com',
    event_time: 1367890356})
Event.create(
    {action: 'email signup',
    doer: 'marty@example.com',
    event_time: 1367890361})
Event.create(
    {action: 'dashboard',
    doer: 'michael@example.com',
    event_time: 1367890369})
Event.create(
    {action: 'uploaded',
    doer: 'audrey@example.com',
    event_time: 1367890385})
Event.create(
    {action: 'mac download page',
    doer: 'miles@example.com',
    event_time: 1367890478})
Event.create(
    {action: 'visited site',
    doer: '1077',
    event_time: 1367890499})
Event.create(
    {action: 'visited site',
    doer: '1012',
    event_time: 1367889122})
Event.create(
    {action: 'uploaded',
    doer: '1075',
    event_time: 1367889154})
Event.create(
    {action: 'uploaded',
    doer: '1075',
    event_time: 1367889164})
Event.create(
    {action: 'uploaded',
    doer: '1002',
    event_time: 1367889268})
Event.create(
    {action: 'uploaded',
    doer: '700',
    event_time: 1367889298})
Event.create(
    {action: 'uploaded',
    doer: 'marty@example.com',
    event_time: 1367889607})
Event.create(
    {action: 'uploaded',
    doer: '1123',
    event_time: 1367889611})
Event.create(
    {action: 'uploaded',
    doer: '700',
    event_time: 1367889740})
Event.create(
    {action: 'uploaded',
    doer: 'audrey@example.com',
    event_time: 1367889736})
Event.create(
    {action: 'visited site',
    doer: 'luke@example.com',
    event_time: 1367889731})
Event.create(
    {action: 'page view',
    doer: '1002',
    event_time: 1367889727})

puts '24 events created with "action", "doer", and "event_time" set (this is what we receive in JSON from KM).'
puts ''
puts 'Now we run a script to identify the people who did those events using the "doer" column and set the "person_id" column.'

Event.all.each do |event|
    if Person.find_by_km_userid(event.doer)
        event.person_id = Person.find_by_km_userid(event.doer).id
        event.save
    elsif Person.find_by_email(event.doer)
        event.person_id = Person.find_by_email(event.doer).id
        event.save
    end
end

puts '"person_id" column set for all events.'
