TwitterApp::Application.routes.draw do
  get 'sessions/callback', :to => 'sessions#callback', :as => 'callback'
  resources :sessions
  root :to => 'sessions#new'
end
