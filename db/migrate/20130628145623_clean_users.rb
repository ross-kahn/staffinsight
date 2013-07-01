class CleanUsers < ActiveRecord::Migration
  def change
	remove_column :users, :admin
	remove_column :users, :director
	remove_column :users, :permission_id
	remove_column :users, :role_id
  end
end
