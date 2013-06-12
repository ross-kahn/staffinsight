class AddPermissionToUser < ActiveRecord::Migration
  def up
    add_column :users, :permission_id, :integer
  end
  
  def down
	remove_column :users, :permission_id
  end

end
