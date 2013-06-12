class ChangeNameToStringInSkills < ActiveRecord::Migration
  def change
	change_column(:skills, :name, :string)
  end

  def down
  end
end
