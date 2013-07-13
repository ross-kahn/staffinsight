class ProfilesController < ApplicationController
	
	before_filter :get_user, :except=>[:index]
	before_filter :get_ranks, :only=> [:new, :edit, :create]
	before_filter :get_equipment, :only => [:new, :edit, :create]
	before_filter :get_skills, :only=> [:new, :edit, :create]
	before_filter :default_rank, :only=> [:new, :edit, :create]
	after_filter :build_profile, :only => [:create, :update]
	
	
	def get_user
		@user = current_user
	end
	
	def get_skills
		@skills = Skill.all
		@prof_skills = []
	end
	
	def get_equipment
		@equipment = Equipment.all
		@prof_eq = []
	end
	
	def get_ranks
		@ranks = Rank.all
	end	
	
	def default_rank
		@default_rank = Rank.default()
	end
	
	def build_profile
		if params.has_key?(:skillset)
			params[:skillset].each do |skill| 
				@profile.skills << Skill.find(skill)
			end
		end
		if params.has_key?(:equipmentset)
			params[:equipmentset].each do |eq|
				@profile.equipment << Equipment.find(eq)
			end
		end
	end	
	
  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
		authorize! :list, Profile

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profiles }
    end
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.find(params[:id])
		authorize! :show, @profile

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /profiles/new
  # GET /profiles/new.json
  def new
    @profile = Profile.new
		@user = User.find(params[:id]) #TODO: add graceful failure?
		@profile.id = params[:id]
		authorize! :new, @profile
		
		
		#@profile.user = @user
		
		
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
		@user = @profile.user
		authorize! :update, @profile
		
		@profile.skills.each do |skill|
			@prof_skills << skill.id
		end	
		
		@profile.equipment.each do |eq|
			@prof_eq << eq.id
		end	
		
		respond_to do |format|
      format.html # edit.html.erb
      format.json { render json: @profile }
    end
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(params[:profile])
		@profile.rank_id = params[:rank]
		@profile.user = User.find(params[:user])
		@profile.id = @profile.user.id
		@profile.user.update_attributes(:profile => @profile)
		authorize! :create, @profile
		
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { render action: "new" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = Profile.find(params[:id])
		@profile.skills = [] # prepare for build_profile
		@profile.rank_id = params[:rank]
		authorize! :update, @profile

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
		authorize! :destroy, @profile

    respond_to do |format|
      format.html { redirect_to profiles_url }
      format.json { head :no_content }
    end
  end
end
