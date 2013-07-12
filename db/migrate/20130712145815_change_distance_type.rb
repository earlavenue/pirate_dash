class ChangeDistanceType < ActiveRecord::Migration
  def up
    change_table :uploads do |t|
      t.change :distance, :float
    end
  end

  def down
    change_table :uploads do |t|
      t.change :distance, :integer
    end
  end
end
