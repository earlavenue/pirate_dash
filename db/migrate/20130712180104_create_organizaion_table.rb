class CreateOrganizaionTable < ActiveRecord::Migration
  def change
    create_table :organizations do |o|
      o.string :name
    end
  end
end
