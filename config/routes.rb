ActionController::Routing::Routes.draw do |map|

  map.root :action=> 'show', :controller => 'welcome'

  map.resources :campaigns
  map.resources :shorteners
  map.resources :statistics
  
  map.resources :barcodes, 
    :collection => {
      :create_link => :post,
      :create_sms  => :post, 
      :create_text => :post
    },
  
    :member => {
      :download => :get
    }
  
end
