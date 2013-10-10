class ChangeQuarterColumn < ActiveRecord::Migration
  def change
    rename_column :quarters, :retention, :active
  end
end
