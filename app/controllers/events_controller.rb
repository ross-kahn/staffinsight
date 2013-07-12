class EventsController < ApplicationController

  before_filter :get_equipment, :get_skills
  before_filter :req_skills, :req_equipment
  after_filter :add_joins, :only => [:create, :update]
  
  def get_equipment
	@equipment = Equipment.all
  end
  
  def get_skills
	@skills = Skill.all
  end
  
  def add_joins
		@event.equipment = []
		if params.has_key?(:required_equipment)
			params[:required_equipment].each do |eq| 
				@event.equipment << Equipment.find(eq)
			end
		end
	
		@event.skills = []
		if params.has_key?(:required_skills)
			params[:required_skills].each do |sk| 
				@event.skills << Skill.find(sk)
			end
		end
  end
  
  def req_skills
		@req_skills = []
  end
  
  def req_equipment
		@req_equipment = []
  end

  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
	
		@event.skills.each do |skill|
			@req_skills << skill.id
		end
		
		@event.equipment.each do |equipment|
			@req_equipment << equipment.id
		end

  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
		
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
