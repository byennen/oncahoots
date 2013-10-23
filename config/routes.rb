CahootsConnect::Application.routes.draw   do
  resources :cities
  resources :universities, only: [:index, :show] do
    resources :events
    resources :university_events, :path => 'calendar', :controller => :university_events do
      
    end
    
    resources :updates, only: [:new, :create, :update, :destroy] do
      resources :comments
    end

    resources :clubs, only: [:show, :new, :create, :edit, :update, :index] do
      resources :club_events, :path => 'events', :controller => :club_events
      post 'transfer_ownership', on: :member
      resources :memberships do
        post 'make_admin', on: :collection
        post 'remove_admin', on: :member
      end
      get :search, on: :collection
      resources :invitations do
        get :search, on: :collection
      end
      resources :club_photos
      resources :club_events
      resources :statuses
      resources :records
      resources :club_newsletters do
        resources :comments
      end
    end
  end

  match "/next_week/:week_start", to: "university_events#next_week"
  match "/prev_week/:week_start", to: "university_events#prev_week"

  resources :updates do
    resources :comments
  end
  resources :relationships do
    get :read, on: :member
    post :accept, on: :member
    post :decline, on: :member
    post :refer, on: :member
    post :accept_recommendation, on: :member
    post :decline_recommendation, on: :member
  end

  match '/signup/:invitation_token', to: 'memberships#new', as: 'signup'
  get '/search', to: 'search#index', as: 'search'
  get '/search/club', to: "search#club"
  get '/search/person', to: "search#person"

  devise_for :users, :controllers => { :registrations => "registrations", :sessions => "sessions" }
  devise_scope :user do
    get "sign_out", :to => "sessions#destroy"
  end

  resources :users do
    resources :profiles
    resource :profile do
      post :contact_requirements, on: :member
    end
    resources :contacts do
      collection do
        get :search
      end
    end
    match '/skip', to: 'profiles#skip', as: 'skip_profile'
    collection do
      get :search
    end

  end

  match "upload_avatar", to: "profiles#upload_avatar", via: :post

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
