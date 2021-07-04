Rails.application.routes.draw do

  #
  # Open routes to the app
  #
  get  'sign_in', to: 'welcome#log_in'
  post 'sign_in_user', to: 'welcome#access_user'
  post 'sign_in_institution', to: 'welcome#access_institution'

  #
  # User acess routes
  #
  resource :user
  
  namespace :user do
    #
    # User root
    #
    root :to => 'user#profile' 

    get 'tickets', action: :index, controller: 'tickets'
  end


  #
  # Intitutions acess routes
  #
  resource :institutions

  get 'institution/profile', action: 'profile', controller: 'institutions'
  get 'institution', to: redirect('/institution/profile')

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
  # Devise for Admin Authentication
  #
  devise_for :admins, path: 'admin', controllers: {sessions: "admin/sessions", passwords: "admin/passwords", registrations: "admin/registrations"}

  #
  # Devise for Users Authentication
  #
  devise_for :users, path: 'user', controllers: { sessions: "users/sessions", passwords: "users/passwords", registrations: "users/registrations"}

  #
  # Devise for Institutions Authentication
  #
  devise_for :institutions, path: 'institution', controllers: { sessions: "institutions/sessions", passwords: "institutions/passwords", registrations: "institutions/registrations"}

  #
  # Main App Page
  #
  root :to => "welcome#home"

end
