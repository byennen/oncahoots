CahootsConnect::Application.routes.draw   do

  devise_for :users, :controllers => { :registrations => "registrations" }

  resources :users do
    match 'build-your-profile', to: 'profiles#new', as: 'build_your_profile'
    resources :profiles
  end

  namespace :admin do
    resources :users
  end

  root :to => "home#index"
end