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
end
