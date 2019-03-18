class AddAvatarToOrganization < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :avatar, :string
  end
end
