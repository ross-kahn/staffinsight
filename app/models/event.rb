class Event < ActiveRecord::Base
  attr_accessible :location, :name, :time
  
  validates_presence_of :location, :name, :time
  
  has_and_belongs_to_many :skills  
  has_and_belongs_to_many :equipment
  has_and_belongs_to_many :responders, :class_name => "Employee"


  def potentials
	
	skill_pot = []
	skills.each do |skill|
		skill.employees.each do |employee|
			skill_pot << employee
		end
	end
	
	eq_pot = []
	equipment.each do |equipment|
		equipment.handlers.each do |employee|
			eq_pot << employee
		end
	end
	
	return (skill_pot | eq_pot)
  end
  
  # The equipment status for the entire event.
  # Returns:	Status 'Working' if all equipment is 'Working'
  #				Status 'Needs Attention' if there is at least one 'Needs Attention' equipment but no 'Broken' equipment
  #				Status 'Broken' if there is at least one 'Broken' equipment
  def equipment_status
	
	stat = Status.where(:name => "Working").first
	
	equipment.each do |equipment|
		if( equipment.status.name == "Broken")
			return equipment.status
		elsif (equipment.status.name == "Needs Attention")
			stat = equipment.status
		end
	end
	return stat
  end
  
end
