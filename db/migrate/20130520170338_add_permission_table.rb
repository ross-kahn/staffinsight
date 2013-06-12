class AddPermissionTable < ActiveRecord::Migration
  def up
    create_table :permissions do |t|
      t.string :name

      t.timestamps
	end
  end

  def down
  end
end
