class AddcolumnstoUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :total_steps, :integer
    add_column :uploads, :total_aerobic_steps, :integer
    add_column :uploads, :calories, :integer
    add_column :uploads, :distance, :integer
  end
end
