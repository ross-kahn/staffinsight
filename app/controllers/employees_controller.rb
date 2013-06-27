class EmployeesController < ApplicationController

  before_filter :get_skills, :only => [:new, :create, :edit, :update]
  before_filter :get_ranks, :only => [:new, :create, :edit, :update]
  before_filter :employee_skills
  after_filter :build_employee, :only => [:new, :create, :edit, :update]
  before_filter :gen_auth, :only => [:edit, :destroy]
  
  def gen_auth
	@admin = current_user.admin?
	@director = current_user.director?
	if not(@admin || @director)
		redirect_to employees_url, :notice => "You are not authorized for this action"
		return
	end
  end
  
  def get_skills
	@skills = Skill.all
  end
  
  def get_ranks
	@ranks = Rank.all
  end
  
  def employee_skills
	@emp_skills = []
  end
  
  def build_employee
	if params.has_key?(:skillset)
		params[:skillset].each do |skill| 
			@employee.skills << Skill.find(skill)
		end
	end
  end
  
  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @employees }
    end
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    @employee = Employee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @employee }
    end
  end

  # GET /employees/new
  # GET /employees/new.json
  def new
    @employee = Employee.new
	
	if params[:id]
	  @user = User.find( params[:id] )
	else
	  redirect_to root_path
	end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @employee }
    end
  end

  # GET /employees/1/edit
  def edit
	@employee = Employee.find(params[:id])
	
	@employee.skills.each do |skill|
	  @emp_skills << skill.id
	end		
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(params[:employee])
	@employee.rank_id = params[:rank]
	
    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render json: @employee, status: :created, location: @employee }
      else
        format.html { render action: "new" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /employees/1
  # PUT /employees/1.json
  def update
    @employee = Employee.find(params[:id])
	@employee.skills = []
	@employee.rank_id = params[:rank]
	
    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
	
	@employee = Employee.find(params[:id])
	name = @employee.name
	@employee.destroy

	respond_to do |format|
	  flash[:notice] = "You have successfully fired " + name
	  format.html { redirect_to employees_url }
	  format.json { head :no_content }
	end
  end
end
