NuxWS::Application.routes.draw do
  match "/donations/ipn", :to => "donations#ipn"
  match "/donations/thanks", :to => "donations#thanks"
  match "/donations/cancel", :to => "donations#cancel"
  match "/donations/list", :to => "donations#list"
  resources :donations

  resources :users do
    get "messages", :to => "users#messages"
    get "topics", :to => "users#topics"
  end
  resources :user_sessions
  resources :places
  match "/forums/mark_all_read", :to => "forums#mark_all_read"
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
  resources :logs

  resources :password_resets, :only => [ :new, :create, :edit, :update ]

  match "/login", :to => "user_sessions#new"
  match "/logout", :to => "user_sessions#destroy"
  match "/settings", :to => "settings#update", :via => :put

  root :to => "application#index"
end
