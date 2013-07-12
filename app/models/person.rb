class Person < ActiveRecord::Base
  attr_accessible :dev_serial, :km_userid, :omron_userid, :first_name, :last_name, :email

  has_many :events
  has_many :uploads

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash
      person = Person.new
      person.first_name = row_hash["User Name"].split(" ")[0]
      person.last_name = row_hash["User Name"].split(" ")[1]
      person.email = person.last_name + "@gmail.com"
      person.dev_serial = "HJ" + rand(9383838).to_s
      person.organization = "Rush Hospital" #eventually dynamic
        if Person.find_by_last_name(person.last_name)
        else
        person.save!
        end
    end
  end

  def self.search_last_name_results(query)
    Person.where last_name: query
  end

  def self.search_serial_results(query)
    Person.where dev_serial: query
  end

  def lifetime_steps
    p_steps = []
    self.uploads.each do |upload|
      p_steps << upload.total_steps
    end
    p_steps.inject {|sum, n| sum + n}
  end
end
