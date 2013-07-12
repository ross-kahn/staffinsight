class EquipmentController < ApplicationController

  before_filter :get_statuses, :only => [:new, :edit, :create, :update]
  before_filter :get_profiles, :only => [:new, :edit, :create, :update]
  before_filter :equipment_handlers
  after_filter :build_handlers, :only => [:create, :update]

  def get_statuses
    @statuses = Status.all
  end
  
  def get_profiles
		@profiles = Profile.all
  end
  
  def equipment_handlers
		@eq_handlers = []
  end
  
  def build_handlers
		@equipment.handlers = []
		if params.has_key?(:handlers)
			params[:handlers].each do |handler| 
				@equipment.handlers << Profile.find(handler)
			end
		end
  end

  # GET /equipment
  # GET /equipment.json
  def index
    @equipment = Equipment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @equipment }
    end
  end

  # GET /equipment/1
  # GET /equipment/1.json
  def show
    @equipment = Equipment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @equipment }
    end
  end

  # GET /equipment/new
  # GET /equipment/new.json
  def new
    @equipment = Equipment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @equipment }
    end
  end

  # GET /equipment/1/edit
  def edit
    @equipment = Equipment.find(params[:id])
	
		@equipment.handlers.each do |handler|
			@eq_handlers << handler.id
		end
  end

  # POST /equipment
  # POST /equipment.json
  def create
    @equipment = Equipment.new(params[:equipment])
	
		@equipment.status_id = params[:status]

    respond_to do |format|
      if @equipment.save
        format.html { redirect_to @equipment, notice: 'Equipment was successfully created.' }
        format.json { render json: @equipment, status: :created, location: @equipment }		
      else
        format.html { render action: "new" }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /equipment/1
  # PUT /equipment/1.json
  def update
    @equipment = Equipment.find(params[:id])

		@equipment.status_id = params[:status]
	
    respond_to do |format|
      if @equipment.update_attributes(params[:equipment])
        format.html { redirect_to @equipment, notice: 'Equipment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment/1
  # DELETE /equipment/1.json
  def destroy
    @equipment = Equipment.find(params[:id])
    @equipment.destroy

    respond_to do |format|
      format.html { redirect_to equipment_index_url }
      format.json { head :no_content }
    end
  end
end
