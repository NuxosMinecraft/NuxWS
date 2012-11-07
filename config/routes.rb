NuxWS::Application.routes.draw do
  resources :mailings

  resources :pms do
    get "mark_read", :to => "pms#mark_read"
  end

  match "/donations/ipn", :to => "donations#ipn"
  match "/donations/thanks", :to => "donations#thanks"
  match "/donations/cancel", :to => "donations#cancel"
  match "/donations/list", :to => "donations#list"
  resources :donations

  resources :users do
    get "messages", :to => "users#messages"
    get "topics", :to => "users#topics"
    get "topics_notifications", :to => "users#topics_notifications"
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
      match :follow, :to => "topics#follow"
      match :unfollow, :to => "topics#unfollow"
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
  resources :search

  # ADMIN PART
  # This is the admin part, some are non-restfull 'cause they can't be restfull.
  # This is not really database-backend but API calls...
  get "/admin", :to => "admin#index"
  namespace :admin do
    resources :worlds, :only => [:index] do
      post "set_time", :to => "worlds#set_time"
    end
    resources :plugins, :only => [:index]
  end
  # END ADMIN PART


  match "/login", :to => "user_sessions#new"
  match "/logout", :to => "user_sessions#destroy"
  match "/settings", :to => "settings#update", :via => :put
  match "/pony", :to => "application#pony", :via => :get

  root :to => "application#index"

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end

end
