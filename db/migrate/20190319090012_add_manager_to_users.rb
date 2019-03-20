class AddManagerToUsers < ActiveRecord::Migration[5.2]
  def change
  	  change_table :users do |t|
      t.references :manager, index: true
  end
  end
end
