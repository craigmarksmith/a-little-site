ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  map.root :controller => "search", :action => "new"

  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'

  map.resources :user_sessions
  map.search '/search', :controller => 'search', :action => 'search'

  map.resources :invalid_digs

  map.resources :digs, :collection => {:authorise => :post} do |digs|
    digs.resources :images
  end

  map.faq 'faq', :controller => 'static', :action => 'faq'

  map.namespace :admin do |admin|
    admin.homepage '/', :controller => "home"
    admin.resources :theatres
    admin.resources :invalid_dig_messages
    admin.resources :digs, :collection => {:upload_dig_sheet_form => :get, :upload_dig_sheet => :post, :regenerate_dig_path => :post, :toggle_published => :post} do |digs|
      digs.resources :images
    end
    admin.resources :dig_types
    admin.resources :tours
    admin.resources :users
  end

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
