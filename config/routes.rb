Rails.application.routes.draw do

  #
  # Devise for Admin Authentication
  #
  devise_for :admins, path: 'admin', controllers: {sessions: "admin/sessions", passwords: "admin/passwords", registrations: "admin/registrations"}

  #
  # Admin area rounting
  #
  namespace :admin do

    #
    # Admins Root
    #
    root :to => 'users#index' 

    resources :users, only: [:index, :destroy, :show, :new, :create, :update, :edit]

    resources :institutions, only: [:index, :destroy, :show, :new, :create, :update, :edit]

    resources :raffles, only: [:show, :edit, :destroy]
      
    get 'institutions_approval',  action: :institutions_approval, controller: 'institutions'
    get 'aprove_institution/:id', action: :aprove_institution,    controller: 'institutions', as: 'approve_institution'

    get 'raffles',                action: :index,                 controller: 'raffles'

    get 'financial',              action: :index,                 controller: 'financial'

    get 'withdraws',              action: :index,                 controller: 'withdraws'

    get 'reports',                action: :reports,               controller: 'reports'

  end

  #
  # Devise for Users Authentication
  #
  devise_for :users, path: 'user', controllers: { sessions: "users/sessions", passwords: "users/passwords", registrations: "users/registrations"}

  #
  # User acess routes
  #
  scope module: 'users' do
    resources :users
  end
  
  namespace :users do

    #
    # User root
    #
    root :to => 'dashboard/users#profile' 

    #
    # User profile actions
    #
    namespace :dashboard do
      root :to => 'users#profile'

      get 'tickets',     action: :index, controller: 'tickets'
      get 'wallet',      action: :show,  controller: 'wallets'
    end
  end

  #
  # Devise for Institutions Authentication
  #
  devise_for :institutions, path: 'institutions', controllers: { sessions: "institutions/sessions", passwords: "institutions/passwords", registrations: "institutions/registrations"}

  scope module: 'institutions' do
    resources :institutions
  end

  # Admin Root
  namespace :institutions do
    namespace :dashboard do
      #
      # Intitutions root
      #
      root :to => 'dashboard/institutions#profile'

      resources :raffles

      resources :institutions, only: [:edit, :update]

      get 'profile', action: :profile, controller: 'institutions'

      get 'wallet', action: :show,  controller: 'wallet'
    end
  end

  #
  # Open routes to the app
  #
  get  'sign_in', to: 'welcome#log_in'
  post 'sign_in_user', to: 'welcome#access_user'
  post 'sign_in_institution', to: 'welcome#access_institution'

  #
  # Main App Page
  #
  root :to => "welcome#home"

end
