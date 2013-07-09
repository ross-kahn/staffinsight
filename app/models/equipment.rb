class Equipment < ActiveRecord::Base
  attr_accessible :name, :status_id, :employee_id, :profile_id
  
  validates_presence_of :name
  validates_presence_of :status_id
	#validates_presence_of :profile_id
  
  validates_uniqueness_of :name
  
  belongs_to :manager, :class_name => "Employee"
	belongs_to :managerp, :class_name => "Profile"
  belongs_to :status
  has_and_belongs_to_many :handlers, :class_name => "Employee"
	has_and_belongs_to_many :handlersp, :class_name => "Profile"
  
  def manager
		return Employee.find(employee_id)
  end
	
	def managerp
		return Profile.find(profile_id)
  end
end
