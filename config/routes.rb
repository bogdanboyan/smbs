require 'rackup'

Smbs::Application.routes.draw do

  root  :to       => 'welcome#show'
  
  post 'invite'   => 'invite#create'

  get  'login'    => 'sessions#new'
  post 'login'    => 'sessions#create'
  get  'logout'   => 'sessions#destroy'
  
  resources :user_activations, :password_resets
  
  match '/analytic/:source/:id/:member.json' => Rackup::AnalyticDataSourceApp.action(:fetch)
  match '/shorteners/:short/redirect'        => Rackup::ShortenersRedirectApp.action(:redirect)

  # yamco console
  namespace :admin do

    resource  :dashboard

    resources :invites
    resources :accounts do
      member           { get :settings; put :activate; put :disable; put :pretend; get :stop_pretend }
      resources :users do
        member         { put :invite; put :activate; put :disable;   }
      end
    end
  end
  
  namespace :reseller do
    resource :dashboard
  end
  
  namespace :business do
    resource :dashboard
  end

  resources :shorteners

  resources :statistics do
    member { get :details }
  end

  resources :barcodes do
    collection { post :create_link; post :create_sms; post :create_text }
    member     { get :download }
  end

  namespace :mobile do
    
    resources :campaigns do
       member     { get :settings;  put :assign_short_url; put :generate_short_url }
       collection { get :ids_with_images }
       
       resources  :images
    end
    
  end
  
  
  # mobile application routing schema
  # =================================
  namespace :mobile_app, :host => Global.host_mobi do
    get '/'                     => 'welcome#index',  :as => :root
    get '/campaigns/:id'        => 'campaigns#show', :as => :campaign
    get '/shorteners/:action'   => 'shorteners',     :as => :shorteners
  end
  
end
