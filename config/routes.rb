require 'rackup'

Smbs::Application.routes.draw do

  root  :to       => 'welcome#show'
  
  post  'invite' => "invite#create"

  get  'login'    => 'sessions#new'
  post 'login'    => 'sessions#create'
  
  get  'logout'   => 'sessions#destroy'
  
  match '/analytic/:source/:id/:member.json' => Rackup::AnalyticDataSourceApp.action(:fetch)
  match '/shorteners/:short/redirect'        => Rackup::ShortenersRedirectApp.action(:redirect)
  get   '/mobile/campaigns/:id'              => Rackup::MobileCampaignsApp.action(:show), :id => /\d+/
  get   '/mobile'                            => Rackup::MobileApp.action(:index)

  # admin console
  namespace :admin do
    
    resource :dashboard
    
  end

  resources :shorteners

  resources :statistics do
    member { get :details }
  end

  resources :barcodes do

    collection do
      post :create_link
      post :create_sms
      post :create_text
    end

    member do
      get :download
    end

  end

  namespace :mobile do
    
    resources :campaigns do
       member     { get :settings;  put :assign_short_url; put :generate_short_url }
    end
    
    resources :assets do
       collection { post :upload_image }
    end
    
  end

end
