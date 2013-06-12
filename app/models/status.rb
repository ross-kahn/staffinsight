class Status < ActiveRecord::Base
  attr_accessible :name
  
  validates_uniqueness_of :name
  
  has_many :equipment #, inverse_of => :equipment
  
  def color
	if name == "Broken"
		color = "red"
	elsif name == "Needs Attention"
		color = "orange"
	elsif name == "Working"
		color = "green"
	else
		color = ""
	end
	return color
  end

end
