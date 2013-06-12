class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :get_roles
  
  def get_roles
	@roles = Role.all
  end

  def new
    resource = build_resource({})
	@default_role = Role.where(:name=>"ReadOnly").first
	respond_with resource
  end
  
  def create
	resource = build_resource(params[:users])
	resource.role_id = params[:role]
	
	if(resource.save)
	  sign_in(resource_name, resource)
	  respond_with resource, :location => after_sign_up_path_for(resource)
	else
	  render :action => "new"
	end
  end
  
  
end 