class ModifyModel < ActiveRecord::Migration
  def change
    create_table :employees_skills, :id => false do |t|
	  t.references :employee, :null => false
	  t.references :skill, :null => false
	end
	
	create_table :status do |s|
      s.string :name

      s.timestamps
    end
	
	add_index(:employees_skills, [:employee_id, :skill_id])
	
	add_column :equipment, :status_id, :integer
  end

  def down
  end
end
