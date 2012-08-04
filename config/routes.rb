Bugtracker::Application.routes.draw do
  root :to=>"login#index"
  
  resources :bugs

  resources :projects

  resources :users 
  resources :roles  
  match "login",:to =>"login#index"
  match "authenticate",:to =>"login#authenticate"
  match "logout", :to=>"login#logout"
  match "assignedme", :to=>"bugs#assignedme"
  match "assignedby", :to=>"bugs#assignedby"
  match "bugsearch", :to=>"bugs#bugsearch"
  match "addcomments", :to=>"bugs#addcomments"
  match "comments", :to=>"bugs#savecomments"
  match "openissue", :to=>"bugs#openissue"
  match "closedissue", :to=>"bugs#closedissue"
  match "fixedissue", :to=>"bugs#fixedissue"
  match "reopenedissue", :to=>"bugs#reopenedissue"
  match "createlabel",:to => "bugs#createlabel"
  match "labeldefects",:to => "bugs#labeldefects"
  match "managelabels",:to => "bugs#managelabels"
  match "cancellabel",:to => "bugs#cancellabel"
  match "deletelabel",:to => "bugs#deletelabel"
  match "download",:to => "bugs#download"



  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

