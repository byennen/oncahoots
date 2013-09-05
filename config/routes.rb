CahootsConnect::Application.routes.draw   do

  resources :universities, only: [:index, :show] do
    resources :updates, only: [:new, :create, :update, :destroy]
    resources :clubs, only: [:show, :new, :create] do
      resource :memberships
      resources :invitations
    end
  end

  match '/signup/:invitation_token', to: 'memberships#new', as: 'signup'


  devise_for :users, :controllers => { :registrations => "registrations" }

  resources :users do
    resources :profiles
    match '/skip', to: 'profiles#skip', as: 'skip_profile'
  end

  namespace :admin do
    resources :universities
    resources :locations
    resources :clubs
    resources :users
    root to: 'dashboard#index'
  end

  root :to => "home#index"
end
