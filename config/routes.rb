CahootsConnect::Application.routes.draw   do

  resources :clubs, only: [:show]

  resources :universities, only: [:index, :show] do
    resources :updates, only: [:new, :create, :update, :destroy]
  end

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