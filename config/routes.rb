ActionController::Routing::Routes.draw do |map|
  map.root :action => "overview", :controller => "gadgets"
  map.resources :gadgets,
    :member => {:detail => :get},
    :collection => {:overview => :get} do |gadgets|
      gadgets.resources :parts
  end
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
