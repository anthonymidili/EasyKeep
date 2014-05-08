EasyKeep::Application.routes.draw do
  devise_for :users,
             :controllers => { :registrations => 'users/registrations', :invitations => 'users/invitations' }
  resource :company do
    member do
      get :income_report
      get :search_invoices
      get :about
      delete 'delete_user/:id', to: 'companies#delete_user', as: :delete_user
    end
  end

  resources :accounts do
    post :invite_customer
  end

  resources :services, except: [:show, :index, :new] do
    collection do
      put :invoice
    end
  end

  resources :invoices, except: [:new, :create] do
    collection do
      put :add_services
      put :remove_services
      put :change_account_header
    end
    member do
      get :invoice_ready
    end
    resources :payments, except: [:show, :index]
  end

  get 'developer/dashboard'
  delete 'developer/destroy/:id', to: 'developer#destroy', as: :developer_delete

  get :about, to: 'welcome#about'
  get :contact_us, to: 'welcome#contact_us'

  get 'sitemap.xml' => 'welcome#sitemap', format: :xml, as: :sitemap

  root to: 'welcome#home'

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
