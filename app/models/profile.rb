class Profile < ActiveRecord::Base
  attr_accessible :title, :rank, :user
	attr_writer :accepted_events
	attr_writer :denied_events
	
	validates_presence_of :rank
	
	has_and_belongs_to_many :skills
	has_many :manages, :class_name => "Equipment"	# Manager for
  has_and_belongs_to_many :equipment	# Handler for
  has_and_belongs_to_many :subscriptions, :class_name => "Event"
	
	belongs_to :rank
  belongs_to :user, :readonly=>true,
						inverse_of: :profile, dependent: :destroy	# The authentication model associated with each employee model
	
	def name
		if (user.nil?)
			return "No Associated User!"
		else
			return user.name
		end
	end
	
	def email
		return user.email
	end
	
	def permission
		return user.role
	end
	
	def accepted_events
		@accepted_events || []
	end
	
	def denied_events
		@denied_events || []
	end
	
	def accept(event)
		if(event.accept(self))
			denied_events.delete(event)
			accepted_events << event
			return true
		else
			return false
		end
	end
	
	def deny(event)
		if(event.deny(self))
			accepted_events.delete(event)
			denied_events << event
			return true
		else
			return false
		end
	end
end
