class AddPhoneToOrganization < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :phone, :string
  end
end
