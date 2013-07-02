class Event < ActiveRecord::Base
  attr_accessible :action, :doer, :event_time, :person_id

  belongs_to :person
end
