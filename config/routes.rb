require 'rackup'

Smbs::Application.routes.draw do

  match '/analytic/:source/:id/:member.json' => Rackup::AnalyticDataSourceApp.action(:fetch)
  match '/shorteners/:short/redirect' => Rackup::ShortenersRedirectApp.action(:redirect)
  get   '/mobile/campaigns/:id'       => Rackup::MobileCampaignsApp.action(:show), :id => /\d+/

  root :to => 'welcome#show'

  resources :shorteners, :statistics

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
       member     { get :preview }
    end
    
    resources :assets do
       collection { post :upload_image }
    end
    
  end

end
