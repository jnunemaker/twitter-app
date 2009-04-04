ActionController::Routing::Routes.draw do |map|
  map.resources :users, :has_one => [:password, :confirmation]
  map.resource :session
  map.resources :passwords
end
