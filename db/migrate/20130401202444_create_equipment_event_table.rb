class CreateEquipmentEventTable < ActiveRecord::Migration
  def change
	create_table :equipment_events, :id => false do |t|
	  t.references :equipment, :null => false
	  t.references :event, :null => false
	end
	
	add_index(:equipment_events, [:equipment_id, :event_id])
  end

  def down
  end
end
