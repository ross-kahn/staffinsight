class Equipment < ActiveRecord::Base
  attr_accessible :name, :status_id, :employee_id
  
  validates_presence_of :name
  validates_presence_of :status_id
  validates_presence_of :employee_id
  
  validates_uniqueness_of :name
  
  belongs_to :manager, :class_name => "Employee"
  belongs_to :status
  has_and_belongs_to_many :handlers, :class_name => "Employee"
  
  def manager
	return Employee.find(employee_id)
  end
end
