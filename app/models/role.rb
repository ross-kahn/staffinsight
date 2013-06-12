class Role < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name
  
  validates_presence_of :name
  
  has_many :users
  
end
