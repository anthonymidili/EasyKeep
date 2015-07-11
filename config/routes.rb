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
  post 'services/dashboard_create'
  get 'dashboard/developer', as: :developer_dashboard
  get 'dashboard/developer/:all_users', to: 'dashboard#developer', as: :all_users

  resources :accounts do
    post :invite_customer, on: :member
  end

  resources :services, except: [:show, :index, :new] do
    get :history_search, on: :collection
  end

  resources :invoices, except: [:new] do
    collection do
      patch :add_services
      patch :remove_services
    end
    member do
      get :invoice_ready
      patch :change_account_header
    end
    resources :payments, except: [:show, :index]
  end

  resources :reports, only: [:index] do
    collection do
      get :income
      get :income_accounts, path: '/income/accounts'
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
