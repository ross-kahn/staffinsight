class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
  
		user ||= User.new # guest user (not logged in)
		if user.role == "Director"
			can :manage, :all
		
		elsif user.role == "Admin"			
			can :manage, Event
			
			can :manage, Profile
			cannot :destroy, Profile
			
			can :edit_rank
			can :edit_title
			
			can :manage, Equipment
			
			can :manage, Skill
			
			can [:create, :read], User
			can :see_admin_options, User
			can :edit_own_user, User
			can :edit_any_user, User
			
			can :manage, Rank
			
		elsif user.role == "Basic"
			can [:create, :update, :read], Event
			cannot :choose_event_staff, Event
			
			########## Profile #####################################################
				can [:read, :create, :update, :list], Profile
				cannot :edit_other_profile, Profile
				cannot :edit_rank
				
				# Can only enter title on creation, cannot edit
				can :edit_title, Profile do |profile|
					profile.new_record?
				end
			
			########## Equipment ###################################################
			# NOTE: Haven't implemented the in-form blocks yet
				can [:read, :create, :update], Equipment
				cannot :set_equipment_managers, Equipment
				cannot :set_equipment_handlers, Equipment
			
      ########## Skill #######################################################
				can [:read, :create], Skill
				cannot :choose_staff, Skill
			
		elsif user.role == "Read-Only"
			can :read, Event
			
			########## Profile #####################################################
			
				cannot :list, Profile	# Can't see staff list
				
				# Can create a new profile only if the current user
				# doesn't have a profile yet. This will allow the
				# user to create a profile for themselves, and then
				# subsequently not be allowed to create any other users
				can :new, Profile, :id => user.id
				can :create, Profile, :id => user.id
				
				# Can see only their own Profile
				can :show, Profile, :user_id => user.id
				
				# Allowed to enter their title only on creation.
				can :edit_title, Profile do |profile|
					profile.new_record?
				end
			
				# A read-only user can never change their payment status
				cannot :edit_rank, Profile
			
			########## Equipment ###################################################

				can :read, Equipment
				cannot :new, Equipment
				cannot :delete, Equipment
				cannot :edit, Equipment
			
			########## Skill #######################################################
				can :read, Skill

		end
    
		
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
