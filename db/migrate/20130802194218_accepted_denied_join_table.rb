class AcceptedDeniedJoinTable < ActiveRecord::Migration
  def change
		create_table :accepted_events, id: false do |t|
			t.integer :profile_id
			t.integer :event_id
		end
		
		create_table :denied_events, id: false do |t|
			t.integer :profile_id
			t.integer :event_id
		end
	end
end
