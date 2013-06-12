class Employee < ActiveRecord::Base
  attr_accessible :name, :rank, :title, :email
  
  validates_presence_of :name
  validates_presence_of :title 
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :rank
  
  validates_format_of :email, :with => /^.+@([A-Z]+\.)+[A-Z]{3}$/i
  
  has_and_belongs_to_many :skills
  has_many :manages, :class_name => "Equipment"	# Manager for
  has_and_belongs_to_many :equipment	# Handler for
  has_and_belongs_to_many :subscriptions, :class_name => "Event"
  
  belongs_to :rank
  belongs_to :user	# The authentication model associated with each employee model
  
end
