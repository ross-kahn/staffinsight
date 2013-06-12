class CreateEventsSkillsJoinTable < ActiveRecord::Migration
  def change
	create_table :events_skills, :id => false do |t|
	  t.references :skill, :null => false
	  t.references :event, :null => false
	end
	
	add_index(:events_skills, [:event_id, :skill_id])

  end

  def down
  end
end
