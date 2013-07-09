class ConnectEmployeesAndUsers < ActiveRecord::Migration
  def change
		add_column :users, :employee_id, :integer
		add_column :employees, :user_id, :integer
  end

end
