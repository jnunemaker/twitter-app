ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'statuses'
  map.resources :users, :has_one => [:password, :confirmation]
  map.resource :session
  map.resource :authorization
  map.resources :passwords
end
