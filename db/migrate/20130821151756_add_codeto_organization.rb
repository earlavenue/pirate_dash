class AddCodetoOrganization < ActiveRecord::Migration
  ###First migration after we copied down the OF database. When we did so we deleted all our previous migrations so that we could copy down the schema as we had it. We merged two schema files so we didn't need the migrations because we had the most up-to-date schema.
  def change
    add_column :organizations, :code, :string
  end
end