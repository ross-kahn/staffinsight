MgmtPrototype::Application.routes.draw do

  devise_for :users, :path_prefix => 'd'
  
	get 'profiles/new', to: "users#new"
  
	resources :users
  resources :ranks
	match 'profiles/new/:id' => 'profiles#new', as: 'new_profile', :id => /[0-9]+/
  resources :profiles, :except => :new
	
	match '/events/recruit/:id' => 'events#recruit'
	match '/events/confirm/:id' => 'events#confirm', :as => 'confirm_event'
	match '/events/confirm/:id/:decision' => 'events#decide', :as => 'event_decision'
	
  resources :events
	resources :statuses
	resources :skills
	resources :equipment

  get "home/home"
  
  #get "/profiles/new/:id", to: "profiles#new", as: "new_profile"
	
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  
  get 'equipment' => "Equipment#index", :as => 'all_equipment'

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#home'
  
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
