class Event < ActiveRecord::Base
  attr_accessible :action, :doer, :event_time
end
