class ChangeQuarterSummariesName < ActiveRecord::Migration
  def change
    rename_table :quarter_summaries, :device_quarters
    rename_table :quarters, :person_quarters
  end
end
