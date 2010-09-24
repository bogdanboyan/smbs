ActionController::Routing::Routes.draw do |map|

  # new routing schema
  # sms/campaigns    | sms/capaign/1       | sms/campaign/1/(analytic|report)(.(pdf|csv))    SmsCampaign#resipients

  # mobile/campaings | mobile/campaign/1   | mobile/campaign/1/(analytic|report)(.(pdf|csv)) MobileCampaign#content_model
  #                                            ||
  # shorteners       | ?shortener/1?       | shortener/1/(analytic|report)(.(pdf|csv))
  #                                            ||
  # barcodes         | ?barcodes/1?        | barcodes/1/(download)(analytic|report)(.(pdf|csv))
  # ?statistics      | ?statistics/1
  # campaigns        | campaign/1          |


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

    :member => { :download => :get }


  map.namespace :mobile do |mobile|
    mobile.resources :campaigns, :collection => { :draggable => :get }
    mobile.resources :assets, :collection => { :upload_image => :post }
  end

end
