NuxWS::Application.routes.draw do
  resources :users
  resources :user_sessions
  resources :places
  resources :forums do
    resources :topics do
      match :pin, :to => "topics#pin"
      match :unpin, :to => "topics#unpin"
      match :lock, :to => "topics#lock"
      match :unlock, :to => "topics#unlock"
      resources :messages
    end
  end
  resources :settings
  resources :galleries do
    resources :images
  end
  resources :docs
  resources :forum_categories
  
  match "/login", :to => "user_sessions#new"
  match "/logout", :to => "user_sessions#destroy"
  match "/settings", :to => "settings#update", :via => :put
  
  root :to => "application#index"
end
