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
  
  desc "update geoip db"
  task :update => :environment do
    system('cd tmp && wget -N http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz')
    system('! test -d db/max_mind && mkdir db/max_mind')
    system('gzip -dfvN tmp/GeoLiteCity.dat.gz')
    system('mv -f tmp/GeoLiteCity.dat db/max_mind/GeoLiteCity.dat')
  end
  
end