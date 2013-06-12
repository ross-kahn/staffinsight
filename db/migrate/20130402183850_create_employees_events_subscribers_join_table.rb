class CreateEmployeesEventsSubscribersJoinTable < ActiveRecord::Migration
  def change
	create_table :employees_events, :id => false do |t|
	  t.references :employee, :null => false
	  t.references :event, :null => false
	end
	
	add_index(:employees_events, [:employee_id, :event_id])

  end

  def down
  end
end
