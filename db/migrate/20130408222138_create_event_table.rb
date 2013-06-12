class CreateEventTable < ActiveRecord::Migration
  def change
	drop_table :status
	
	create_table :events do |t|
	  t.string :name
	  t.string :location
	  t.datetime :time
	  
	  t.timestamps
	end
  end

  def down
  end
end
