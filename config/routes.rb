Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  devise_for :users,
             :controllers => { :registrations => 'users/registrations', :invitations => 'users/invitations' }

  resource :company do
    member do
      get :search_invoices
      get :about
      delete 'delete_user/:id', to: 'companies#delete_user', as: :delete_user
    end
  end

  get :dashboard, to: 'dashboard#home'
  get 'dashboard/developer', as: :developer_dashboard
  get 'dashboard/developer/:all_users', to: 'dashboard#developer', as: :all_users

  resources :accounts do
    post :invite_customer, on: :member
  end

  resources :services, except: [:show, :index, :new] do
    collection do
      post :dashboard_create
      post :invoice_create
      get :history_search
    end
  end

  resources :invoices do
    collection do
      post :apply_checked_services_create
    end
    member do
      get :invoice_ready
      patch :change_account_header
      patch :apply_services_update
      patch :remove_services_update
    end
    resources :payments, except: [:show, :index]
  end

  resources :reports, only: [:index] do
    collection do
      get :income
      get 'income/accounts', to: 'reports#income_accounts'
      get 'income/line_graph', to: 'reports#income_line_graph'
      get 'income/bar_graph', to: 'reports#income_bar_graph'
    end
  end

  resources :inventory_items
  get 'search_tag/:tag', to: 'inventory_items#index', as: :tag

  get :about, to: 'welcome#about'
  get :contact_us, to: 'welcome#contact_us'
  get 'sitemap.xml', to: 'welcome#sitemap', format: :xml, as: :sitemap

  root to: 'welcome#home'

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
