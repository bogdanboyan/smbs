ActionController::Routing::Routes.draw do |map|

  map.with_options :controller=> :welcome do |w|
     w.root :action=> 'show'
     w.connect 'g/:short', :action=> 'redirect'
  end

  map.resources :campaigns
  map.resources :shorteners
  map.resources :statistics
  map.resources :barcodes, :collection=>{:create_link=> :post, :create_sms=> :post, :create_text=> :post}
end
