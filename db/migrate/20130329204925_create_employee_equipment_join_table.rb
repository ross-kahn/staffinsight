class CreateEmployeeEquipmentJoinTable < ActiveRecord::Migration
  def change
    create_table :employees_equipment, :id => false do |t|
		t.references :employee, :null => false
		t.references :equipment, :null => false
	end
  end

  def down
  end
end
