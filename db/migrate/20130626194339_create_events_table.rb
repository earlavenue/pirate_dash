class CreateEventsTable < ActiveRecord::Migration
  def change
    create_table :events do |e|
      e.string :action
      e.string :doer
      e.integer :event_time
    end
  end
end
