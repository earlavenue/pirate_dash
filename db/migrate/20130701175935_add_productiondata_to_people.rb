class AddProductiondataToPeople < ActiveRecord::Migration
  def change
    add_column :people, :omron_userid, :integer
    add_column :people, :first_name, :string
    add_column :people, :last_name, :string
    add_column :people, :email, :string
    add_column :people, :gender, :string
    add_column :people, :country, :string
    add_column :people, :city, :string
    add_column :people, :state, :string
    add_column :people, :omron_date_created, :datetime
    add_column :people, :last_visit_time, :datetime
    add_column :people, :last_upload, :datetime
  end
end
