CahootsConnect::Application.routes.draw   do
  resources :cities
  resources :universities, only: [:index, :show] do
    resources :university_events, :path => 'calendar', :controller => :university_events
    resources :updates, only: [:new, :create, :update, :destroy] do
      resources :comments
    end
    resources :clubs, only: [:show, :new, :create, :edit, :update] do
      resources :club_events, :path => 'events', :controller => :club_events
      post 'transfer_ownership', on: :member
      resources :memberships do
        post 'make_admin', on: :collection
        post 'remove_admin', on: :member
      end
      resources :invitations
      resources :club_photos
      resources :club_events
      resources :statuses
      resources :records
      resources :club_newsletters do
        resources :comments
      end
    end
  end
  resources :updates do
    resources :comments
  end
  resources :relationships do
    get :read, on: :member
    post :accept, on: :member
    post :decline, on: :member
  end

  match '/signup/:invitation_token', to: 'memberships#new', as: 'signup'
  get '/search', to: 'search#index', as: 'search'

  devise_for :users, :controllers => { :registrations => "registrations", :sessions => "sessions" }
  devise_scope :user do
    get "sign_out", :to => "sessions#destroy"
  end

  resources :users do
    resources :profiles
    resource :profile
    match '/skip', to: 'profiles#skip', as: 'skip_profile'
    collection do
      get :search
    end
  end

  resources :messages, only: [:create] do
    get :read, on: :member
    post :reply, on: :member
  end

  namespace :admin do
    resources :universities
    resources :locations
    resources :clubs
    resources :users
    root to: 'dashboard#index'
  end

  root :to => "universities#home"
end
