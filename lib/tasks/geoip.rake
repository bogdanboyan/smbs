desc "Helpers for IP geo location environment"
namespace :geoip do
  
  desc "Find last undefined clicks and try find location"
  task :trylocate => :environment do
    count = 0
    Click.find_all_by_located(false).each do |click|
      IpLocation.find_location_for(click) and click.save and count += 1
    end
    count > 0 ? puts("Updated %d records" % count) : puts("Nothing updated")
  end
  
  task :updatedisplay => :environment
  
end