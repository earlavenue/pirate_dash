class CleanUpPeopleTable < ActiveRecord::Migration
  def change
    remove_column :people, :gender
    remove_column :people, :country
    remove_column :people, :state
    remove_column :people, :city
    remove_column :people, :omron_date_created
    remove_column :people, :last_visit_time
    remove_column :people, :last_upload
  end
end
