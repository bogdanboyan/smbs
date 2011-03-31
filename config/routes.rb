require 'rackup'

Smbs::Application.routes.draw do

  root  :to       => 'welcome#show'
  
  post 'invite'   => 'invite#create'

  get  'login'    => 'sessions#new'
  post 'login'    => 'sessions#create'
  get  'logout'   => 'sessions#destroy'
  
  resources :user_activations, :password_resets
  
  
  # logged users tools
  # ==================
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
       member     { get :settings;  put :assign_short_url; put :generate_short_url; put :approve }
       collection { get :ids_with_images }
       
       resources  :images
    end
    
  end
  
  
  # management console
  # ==================
  namespace :admin do

    resource  :dashboard do
      collection   { get :more_activity }
    end

    resources :invites
    
    resources :mobile_campaigns do
      collection { get :pending; get :published; get :draft }
      member     { put :publish; put :cancel; put :unpublish; put :archive }
    end
    
    resources :accounts do
      member           { get :settings; put :activate; put :disable; put :pretend; get :stop_pretend }
      resources :users do
        member         { put :invite; put :activate; put :disable;   }
      end
    end
    
    resources :locations do
      collection { get :countries; get :regions; get :cities }
      member     { put :update_city_display_name; put :update_country_display_name }
    end
    
    resources :tags do
      collection { get :cities; get :places; get :labels }
    end
  end
  
  namespace :reseller do
    resource :dashboard
  end
  
  namespace :business do
    resource :dashboard do
      collection   { get :more_activity }
    end
  end
  
  
  # rackup controllers
  # ==================
  get '/analytic/:source/:id/:member.json' => Rackup::AnalyticDataSourceApp.action(:fetch)
  get '/shorteners/:short/redirect'        => Rackup::ShortenersRedirectApp.action(:redirect)
  get '/mobile_app/likeit/:id'             => Rackup::LikeitRedirectApp.action(:capture), :as => :mobile_app_likeit
  
  
  # mobile application routing schema
  # =================================
  namespace :mobile_app, :host => Global.host_mobi do
    get '/'                     => 'welcome#index',  :as => :root
    get '/campaigns/:id'        => 'campaigns#show', :as => :campaign
    get '/shorteners/:action'   => 'shorteners',     :as => :shorteners
  end
  
end
