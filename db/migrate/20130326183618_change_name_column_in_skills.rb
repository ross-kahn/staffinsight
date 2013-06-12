class ChangeNameColumnInSkills < ActiveRecord::Migration
  def change
	change_column(:skills, :name, :text)
  end

  def down
  end
end
