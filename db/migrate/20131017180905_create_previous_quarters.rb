class CreatePreviousQuarters < ActiveRecord::Migration
  def change
    create_table :quarter_summaries do |t|
      t.string :device_model
      t.integer :activations
      t.date :start_date
    end
  end
end
