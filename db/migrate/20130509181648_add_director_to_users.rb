class AddDirectorToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :director, :boolean, :default => false
  end
  
  def self.down
	remove_column :users, :director
  end
end
