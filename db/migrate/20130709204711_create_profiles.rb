class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.timestamps
			
			t.string :title
			t.integer :rank_id
			t.integer :user_id
    end
	
		create_table "equipment_profiles", :id => false, :force => true do |t|
			t.integer "equipment_id", :null => false
			t.integer "profile_id",  :null => false
		end
		
		create_table "events_profiles", :id => false, :force => true do |t|
			t.integer "event_id",    :null => false
			t.integer "profile_id", :null => false
		end
		
		add_index "events_profiles", ["event_id", "profile_id"], :name => "index_events_profiles_on_event_id_and_profile_id"

		create_table "profiles_skills", :id => false, :force => true do |t|
			t.integer "profile_id", :null => false
			t.integer "skill_id",    :null => false
		end
		
		add_index "profiles_skills", ["profile_id", "skill_id"], :name => "index_profiles_skills_on_profile_id_and_skill_id"

		add_column :equipment, :profile_id, :integer
		
		add_column :users, :profile_id, :integer
		
  end
end
