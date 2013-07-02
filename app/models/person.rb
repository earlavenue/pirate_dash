class Person < ActiveRecord::Base
  attr_accessible :pedserial, :km_userid, :omron_userid, :first_name, :last_name, :email, :gender, :country, :city, :state

  has_many :events

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
    recently_active_people = []
    recent_events = Event.select("DISTINCT(PERSON_ID)").order("EVENT_TIME DESC").limit(10)
    recent_events.each do |event|
      recently_active_people << Person.find_by_id(event.person_id)
    end
    return recently_active_people
  end
end
