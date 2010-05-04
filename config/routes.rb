ActionController::Routing::Routes.draw do |map|

  map.with_options :controller=> :welcome do |w|
     w.root :action=> 'show'
     w.connect 'g/:short', :action=> 'redirect'
  end

  map.resources :shorteners
  map.resources :statistics
end
