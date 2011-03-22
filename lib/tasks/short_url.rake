namespace :short_url do
  
  desc 'summarize all clicks for "proxied" short_url'
  task :summarize_clicks => :environment do
    ShortUrl.where(:current_state => 'proxied').each do |short_url|
      ClicksAgregator.summarize_all_clicks(short_url.id)
    end
  end
  
end