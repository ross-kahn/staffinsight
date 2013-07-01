class User < ActiveRecord::Base

  ROLES = %w[Read-Only Basic Admin Director]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :role
  # attr_accessible :title, :body
  
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :role
  
  def role?(role)
    ROLES.include? role.to_s
  end
  
end
