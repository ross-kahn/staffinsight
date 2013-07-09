class SkillsController < ApplicationController

  before_filter :get_skills, :only => [:index, :new, :create, :update]
  before_filter :get_profiles
	#before_filter :get_employees
  before_filter :skilled
  #after_filter :build_employees, :only => [:create, :update]
	after_filter :build_profiles, :only => [:create, :update]
	
  def get_skills
		@skills = Skill.all
  end
  
  def get_profiles
		@profiles = Profile.all
  end
  
  def skilled
		@skilled = []
  end

  def build_employees
		@skill.profiles = []
		if params.has_key?(:skilled_prof)
			params[:skilled_prof].each do |prof| 
				@skill.profiles << Profile.find(prof)
			end
		end
  end
  
  # GET /skills
  # GET /skills.json
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @skills }
    end
  end

  # GET /skills/1
  # GET /skills/1.json
  def show
    @skill = Skill.find(params[:id])
	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @skill }
    end
  end

  # GET /skills/new
  # GET /skills/new.json
  def new
    @skill = Skill.new
	
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @skill }
    end
  end

  # GET /skills/1/edit
  def edit
    @skill = Skill.find(params[:id])
	
		@skill.profiles.each do |prof|
			@skilled << prof.id
		end
  end

  # POST /skills
  # POST /skills.json
  def create
    @skill = Skill.new(params[:skill])
	
    respond_to do |format|
      if @skill.save
        format.html { redirect_to skills_path, notice: 'Skill was successfully created.' }
        format.json { render json: @skill, status: :created, location: @skill }
      else
        format.html { render action: "new" }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /skills/1
  # PUT /skills/1.json
  def update
    @skill = Skill.find(params[:id])

    respond_to do |format|
      if @skill.update_attributes(params[:skill])
        format.html { redirect_to skills_path, notice: 'Skill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skills/1
  # DELETE /skills/1.json
  def destroy
    @skill = Skill.find(params[:id])
    @skill.destroy

    respond_to do |format|
      format.html { redirect_to skills_url }
      format.json { head :no_content }
    end
  end
end
