class Skill < ActiveRecord::Base
  attr_accessible :name, :parent_id
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_and_belongs_to_many :employees
	has_and_belongs_to_many :profiles
  has_and_belongs_to_many :events
  
  def status_color(event)
	skill = Skill.find(id)
	
	if( event.skills.include?(skill) )
		return "green"
	else
		return "red"
	end
  end
  
end
