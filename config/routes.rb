ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'statuses'
  
  map.resources :statuses, :collection => {:replies => :get}
  map.resources :users, :has_one => [:password, :confirmation]
  map.resources :passwords
  
  map.resource :session
  map.resource :authorization
end
