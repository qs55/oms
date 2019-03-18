class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.string :email
      t.string :token
      t.references :user
      t.references :organization

      t.timestamps
    end
  end
end
