class AddColumnToPersonQuarter < ActiveRecord::Migration
  def change
    add_column :person_quarters, :previous_quarter, :boolean
  end
end
