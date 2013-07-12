class DeprecateEmployee < ActiveRecord::Migration
  def change
		drop_table :employees
		drop_table :employees_equipment
		drop_table :employees_events
		#remove_index :employees_events
		drop_table :employees_skills
		#remove_index :employees_skills
		
		remove_column :equipment, :employee_id
		remove_column :users, :employee_id
  end
end
