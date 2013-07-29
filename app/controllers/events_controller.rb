class EventsController < ApplicationController

  before_filter :get_equipment_skills, :except => [:destroy]
	
  def get_equipment_skills
		@equipment = Equipment.all
		@skills = Skill.all
		
		@req_skills = []
		@req_equipment = []
  end
 
	def populate_equipment_skills
		
		# Populates @req_skills with the id of each required skill for the event
		@event.skills.each do |skill|
			@req_skills << skill.id
		end
		
		# Populates @req_equipment with the id of each required equipment for the event
		@event.equipment.each do |equipment|
			@req_equipment << equipment.id
		end	
	end
 
	def get_recruited_indices
		@recruited = []
		@event.recruited.each do |prof|
			@recruited << prof.id
		end
	end
	
  def add_joins

		@event.equipment = [] if @event.first_step?
		@event.skills = [] if @event.first_step?
		@event.recruited = [] if @event.last_step?
		
		if params[:required_equipment]
			params[:required_equipment].each do |eq| 
				@event.equipment << Equipment.find(eq)
			end
		end
	
		if params[:required_skills]
			params[:required_skills].each do |sk| 
				@event.skills << Skill.find(sk)
			end
		end
		
		if params[:recruited]
			params[:recruited].each do |pot| 
				@event.recruited << Profile.find(pot)
			end
		end
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
		get_recruited_indices
		
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
		session[:event_step] = @event.current_step
		
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end
	
	# POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
		
		if (@event.save)
			@event.next_step
			session[:event_step] = @event.current_step
			add_joins
			redirect_to edit_event_path(@event)
		else
			flash[:alert] = "Event was unable to be saved"
			redirect_to new_event_path
		end
  end
	
	
  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
		@event.current_step = session[:event_step] 
		
		get_recruited_indices
		populate_equipment_skills

  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])
		@event.current_step = session[:event_step]
		add_joins
		
		
		if params[:back_button] # Save and go back
			@event.previous_step	
			session[:event_step] = @event.current_step
			redirect_to edit_event_path(@event)
		elsif params[:next_button]			# save and continue
			if @event.update_attributes(params[:event])

				if @event.last_step?
					session[:event_step] = nil
					@event.current_step = nil
					redirect_to @event
				else
					@event.next_step
					session[:event_step] = @event.current_step
					redirect_to edit_event_path(@event)
				end
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
