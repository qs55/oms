class AddNameToInvite < ActiveRecord::Migration[5.2]
  def change
    add_column :invites, :name, :string
  end
end
