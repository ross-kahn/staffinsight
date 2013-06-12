class AddSelfJoinToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :parent_id, :integer
  end
end
