class Person < ActiveRecord::Base
  attr_accessible :pedserial, :km_userid

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Person.create! row.to_hash
    end
  end

  def self.search_last_name_results(query)
    Person.where last_name: query
  end

  def self.search_serial_results(query)
    Person.where pedserial: query
  end

  def self.recently_active
    # recent_event_doers = []
    # recent_people_as_solo_array = []
    # people_objects = []
    # recent_events = Event.select("DISTINCT(DOER)").order("EVENT_TIME DESC").limit(10)
    # recent_events.each do |event|
    #   recent_event_doers << event.doer
    # end
    # recent_event_doers.each do |doer|
    #   recent_people_as_solo_array << Person.where("km_userid = ? OR email = ?", doer, doer)
    # end
    # recent_people_as_solo_array.each do |array|
    #   people_objects << array[0]
    # end
    # return people_objects
    Person.first(10)

    #lines 19-32 currently raise errors because not all the people in our table have properties defined. If all the rows of the People table had values in place instead of nil, this method should work. For now, I'm just returning the first 10 people in the database.
  end
end
