class Person < ActiveRecord::Base
  attr_accessible :pedserial, :km_userid, :omron_userid, :first_name, :last_name, :email, :gender, :country, :city, :state

  has_many :events


  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Person.create! row.to_hash
    end
  end
#import method supports importing data from EITHER KM or Omron production db. When you import from BOTH sources, the people table will have duplicates. Use the sync method to resolve this problem by identifying duplicates through identical device serial numbers, saving the KM id to the closer-to-complete Omron person row, and deleting the KM duplicate row.

  def self.sync
    people_needing_km_data = Person.where km_userid: nil
    unsynced_km_people = Person.where("km_userid IS NOT NULL AND omron_userid IS NULL")

    people_needing_km_data.each do |person_needing_km_userid|
      unsynced_km_people.each do |person_from_km|
        if person_needing_km_userid.pedserial == person_from_km.pedserial
          person_needing_km_userid.km_userid = person_from_km.km_userid
          person_needing_km_userid.save
          person_from_km.destroy
        end
      end
    end
  end

  def self.search_last_name_results(query)
    Person.where last_name: query
  end

  def self.search_serial_results(query)
    Person.where pedserial: query
  end

  # def self.recently_active
  #   recently_active_people = []
  #   recent_events = Event.select("DISTINCT(PERSON_ID)").order("EVENT_TIME DESC").limit(10)
  #   recent_events.each do |event|
  #     recently_active_people << Person.find_by_id(event.person_id)
  #   end
  #   return recently_active_people
  # end
end
