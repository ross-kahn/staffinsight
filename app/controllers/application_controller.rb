class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
	flash[:error] = exception.message
	redirect_to root_url
  end
  
  def after_sign_up_path_for(resource)
	redirect_to new_employee_path
  end
end
