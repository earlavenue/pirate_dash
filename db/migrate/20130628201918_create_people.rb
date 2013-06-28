class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :pedserial
      t.string :km_userid

      t.timestamps
    end
  end
end
