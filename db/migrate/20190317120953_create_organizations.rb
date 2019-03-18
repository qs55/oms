class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.references :user

      t.timestamps
    end
  end
end
