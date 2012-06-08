NuxWS::Application.routes.draw do
  resources :users
  resources :user_sessions
  resources :places
  resources :forums do
    resources :topics do
      resources :messages
    end
  end
  resources :settings
  
  match "/login", :to => "user_sessions#new"
  match "/logout", :to => "user_sessions#destroy"
  
  root :to => "application#index"
end
