Rails.application.routes.draw do

  # General routes to the app
  get  'sign_in', to: 'welcome#log_in'
  post 'sign_in', to: 'welcome#access'

  #
  # Users scope rounting
  # Devise
  devise_for :users, path: 'user', controllers: { sessions: "users/sessions", passwords: "users/passwords", registrations: "users/registrations"}

  scope module: 'users' do
    resources :users
  end
  
  namespace :users do
    root :to => 'dashboard/users#profile' 
    namespace :dashboard do
      root :to => 'users#profile'

      get 'tickets',     action: :index, controller: 'tickets'
      get 'wallet',      action: :show,  controller: 'wallets'
    end
  end

  #
  # Admin scope rounting
  # Devise
  devise_for :admins, path: 'admin', controllers: { sessions: "admins/sessions", passwords: "admins/passwords", registrations: "admins/registrations"}

  # Admin Root
  namespace :admins do
    root :to => 'dashboard/users#index' 
    namespace :dashboard do
      root :to => 'users#index'

      resources :users

      resources :institutions

      resources :raffles, only: [:show, :edit, :destroy]

      # get 'users',                  action: :index,                 controller: 'users'
      # get 'institutions',           action: :index,                 controller: 'institutions'
      
      get 'institutions_approval',  action: :institutions_approval, controller: 'institutions'
      get 'aprove_institution/:id', action: :aprove_institution,    controller: 'institutions', as: 'approve_institution'

      get 'raffles',                action: :index,                 controller: 'raffles'

      get 'financial',                action: :index,                 controller: 'financial'

      get 'withdraws',              action: :index,                 controller: 'withdraws'

      get 'reports',                action: :reports,               controller: 'reports'
    end
  end

  # Institutions scope rounting
  # Devise
  devise_for :institutions, path: 'institutions', controllers: { sessions: "institutions/sessions", passwords: "institutions/passwords", registrations: "institutions/registrations"}


  scope module: 'institutions' do
    resources :institutions
  end

  # Admin Root
  namespace :institutions do
    root :to => 'dashboard/institutions#profile'
    namespace :dashboard do
      root :to => 'dashboard/institutions#profile'

      resources :raffles

      resources :institutions, only: [:edit, :update]

      get 'profile', action: :profile, controller: 'institutions'

      get 'wallet', action: :show,  controller: 'wallet'
    end
  end


  # End with application root
  root :to => "welcome#home"

end
