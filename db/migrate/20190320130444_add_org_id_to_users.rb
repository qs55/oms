class AddOrgIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :org_id, :bigint
  end
end
