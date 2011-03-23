namespace :short_url do
  
  desc 'summarize all clicks for "proxied" short_url'
  task :summarize_clicks => :environment do
    ShortUrl.where(:current_state => 'proxied').each do |short_url|
      if short_url.clicks_count
        ClicksAgregator.summarize_all_clicks(short_url.id)
        puts "-> try summarize clicks for '#{short_url.link}'"
      end
    end
  end
  
end