class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
	flash[:error] = exception.message
	redirect_to root_url
  end
  
  protected
  
	  def after_sign_in_path_for(resource)
			# Check to see if the resource's associated profile is 'nil'
			if( resource.profile.nil? )
				
				# If the user has a profile associated with it, then proceed normally to the home page
				root_path
			else
			
				# If the user does not yet have a profile, they need to create one before proceeding
				# NOTE: In addition to linking the two objects, change the cancan level. This way,
				# the user can't get to the 'new profile' page and then navigate away
				new_employee_path(resource)
			end
		end	
	
	  def after_sign_up_path_for(resource)
			new_employee_path(resource)
	  end
end
