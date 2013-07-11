class AddPersonIDtoPeople < ActiveRecord::Migration
  def change
    add_column :uploads, :person_id, :integer
  end
end
