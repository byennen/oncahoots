CahootsConnect::Application.routes.draw   do

  resources :universities, only: [:index, :show] do
    resources :updates, only: [:new, :create, :update, :destroy]
  end

  devise_for :users, :controllers => { :registrations => "registrations" }

  resources :users do
    match 'build-your-profile', to: 'profiles#new', as: 'build_your_profile'
    resources :profiles
  end


  namespace :admin do
    resources :universities
    resources :locations
    resources :users
    root to: 'dashboard#index'
  end

  root :to => "home#index"
end