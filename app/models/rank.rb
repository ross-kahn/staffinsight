class Rank < ActiveRecord::Base

	DEFAULT_STRING = "Unknown"

  attr_accessible :name, :description
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
	has_many :profiles
	
	def self.default
	  d_rank = Rank.where(:name=>DEFAULT_STRING).first
		if d_rank.nil?
			d_rank = Rank.create(:name=>DEFAULT_STRING)		
		end
		return d_rank
	end
end
