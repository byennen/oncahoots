CahootsConnect::Application.routes.draw   do

  ### STATIC PAGES TO BE REMOVED
  match '/static/index', to: 'static_pages#index'
  match '/static/about', to: 'static_pages#about'
  match '/static/clubs', to: 'static_pages#clubs'
  match '/static/college', to: 'static_pages#college'
  match 'static/communication', to: 'static_pages#communication'
  match '/static/events', to: 'static_pages#events'
  match '/static/lowdown', to: 'static_pages#lowdown'
  match '/static/members', to: 'static_pages#members'
  match '/static/money', to: 'static_pages#money'
  match '/static/network', to: 'static_pages#network'
  match '/static/photos', to: 'static_pages#photos'
  match '/static/running-club', to: 'static_pages#running_club'
  match '/static/search', to: 'static_pages#search'
  match '/static/search-detail', to: 'static_pages#search_detail'
  match '/static/settings', to: 'static_pages#settings'



  match '/auth/:provider/callback' => 'authentications#create'
  resources :cities
  resources :universities, only: [:show, :update] do

    resources :events
    resources :university_events, :path => 'calendar', :controller => :university_events do
      member do
        get :interested
      end
    end

    member do
      post :create_free_food_event
      put :update_free_food_event
      get :search_events
    end

    resources :updates, only: [:new, :create, :update, :destroy] do
      resources :comments
    end

    resources :clubs, only: [:show, :new, :create, :edit, :update, :index] do
      resources :events, :path => 'events', :controller => :club_events
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
      resources :statuses
      resources :records
      resources :club_newsletters do
        resources :comments
      end
    end

    collection do
      get :auto_search
    end
  end


  resources :metropolitan_clubs, only: [:show, :update] do
    resources :updates
    collection do
      get :home
    end

    member do
      post :assign_leader
      get :search_member
      post :upload_image
      post :upload_photo
    end
  end

  resources :posts do
    resources :comments
  end

  resources :clubs, only: [] do
    resources :updates
    member do
      get :join
      get :search_members
      post :send_message
      post :message_to_club
      post :upload_photo
    end
    collection do
      get :auto_search
    end
    resources :club_events, only: [:create, :update, :destroy]
    resources :transactions, only: [:index] do
      collection do
        put :donate
      end

      member do
        get :refund
      end
    end
    resources :items
  end

  resources :transactions, only: [:create]
  
  match "/metropolitan_club", to: "metropolitan_clubs#home"

  match "/next_week/:week_start", to: "university_events#next_week"
  match "/prev_week/:week_start", to: "university_events#prev_week"
  match "/load_events/:day", to: "university_events#load_events", as: "load_events"

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
  get '/search/event', to: "search#event", as: "search_event"

  devise_for :users, :controllers => { :registrations => "registrations", 
    :sessions => "sessions"}
  
  get 'registrations/finish', to: "registrations#finish"
  devise_scope :user do
    get "sign_out", :to => "sessions#destroy"
    get "finish_signup", to: "registrations#finish"
  end

  resources :users do
    resources :profiles
    resource :profile do
      post :contact_requirements, on: :member
    end
    resources :contacts do
      collection do
        get :search
        get :multi_search
      end
    end
    match '/skip', to: 'profiles#skip', as: 'skip_profile'
    collection do
      get :search
      get :filter
    end

  end

  match "upload_avatar", to: "profiles#upload_avatar", via: :post

  resources :messages, only: [:create, :destroy] do
    get :read, on: :member
    post :reply, on: :member
  end

  resources :alerts do
    get :read, on: :member
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
