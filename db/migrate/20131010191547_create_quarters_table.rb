class CreateQuartersTable < ActiveRecord::Migration
  def change
    create_table :quarters do |t|
      t.string :person_id
      t.date :start_date
      t.boolean :retention
    end
  end
end
