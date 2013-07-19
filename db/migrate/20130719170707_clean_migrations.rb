class CleanMigrations < ActiveRecord::Migration
  def up
		create_table :equipment do |t|
			t.timestamps
			
			t.string :name
			t.integer :status_id
			t.integer :profile_id
		end
		
		create_table :equipment_events, :id => false do |t|
			t.references :equipment, :null => false
			t.references :event, :null => false
		end
		
		add_index(:equipment_events, [:equipment_id, :event_id])
		
		create_table :events do |t|
			t.timestamps
			t.string :name
			t.string :location
			t.datetime :time
		end
		
		create_table :events_profiles, :id => false do |t|
			t.references :event, :null=>false
			t.references :profile, :null=>false
		end
		
		add_index(:events_profiles, [:event_id, :profile_id])
		
		create_table :events_skills, :id=>false do |t|
			t.references :event, :null =>false
			t.references :skill, :null=>false
		end
		
		create_table :profiles do |t|
			t.string :title
			t.integer :rank_id
			t.integer :user_id
			
			t.timestamps
		end
		
		create_table :profiles_skills, :id=>false do |t|
			t.references :profile, :null=>false
			t.references :skill, :null=>false
		end
		
		add_index(:profiles_skills, [:profile_id, :skill_id])
		
		create_table :ranks do |t|
			t.string :name
			t.timestamps
		end	
		
		create_table :skills do |t|
			t.string :name
			t.timestamps
		end
		
		create_table :statuses do |t|
			t.string :name
			t.timestamps
		end
		
		######################## USERS (from devise) #################
		create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## Token authenticatable
      # t.string :authentication_token

			## StaffInSight
			t.string :name, :null=>false, :default=>""
			t.string :role
			t.integer :profile_id

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
		######################################################################
	
  end

  def down
  end
end
