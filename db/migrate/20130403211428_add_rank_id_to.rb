class AddRankIdTo < ActiveRecord::Migration
  def change
	add_column :employees, :rank_id, :integer
  end

  def down
  end
end
