class Event < ActiveRecord::Base
  attr_accessible :location, :name, :time
	attr_writer :current_step
  attr_writer :accepted
	attr_writer :denied
	
  validates_presence_of :location, :name, :time
  #validates_presence_of :location, :if => lambda {|e| e.current_step == 'information'}
	
  has_and_belongs_to_many :skills  
  has_and_belongs_to_many :equipment
  has_and_belongs_to_many :recruited, :class_name => "Profile"


  def potentials
		
		skill_pot = []
		skills.each do |skill|
			skill.profiles.each do |profile|
				skill_pot << profile
			end
		end
	
		eq_pot = []
		equipment.each do |equipment|
			equipment.handlers.each do |profile|
				eq_pot << profile
			end
		end
	
		return (skill_pot | eq_pot)
  end
	
	def accepted
		@accepted || []
	end
	
	# Add the profile to the list of accepted.
	# If the profile's id already exists, don't add it and return false
	def accept(profile)
	  if(accepted.include? profile)
			return false
		else
			self.denied.delete(profile) # Will delete id from denied if it exists
			self.accepted << profile 		# Add id to accepted
			return true
		end
	end
	
	def denied
		@denied || []
	end
	
	def deny(profile)
		self.denied << profile
	end
	
	def current_step
		@current_step || steps.first
	end
	
	def next_step
		self.current_step = steps[steps.index(current_step)+1]
	end
	
	def previous_step
		self.current_step = steps[steps.index(current_step)-1]
	end
	
	def  first_step?
		current_step == steps.first
	end
	
	def  last_step?
		current_step == steps.last
	end
	
	def steps
		%w[information recruit]
	end
  
	def recruits?
		return recruited.length > 0
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
