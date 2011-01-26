require 'highline'

desc "Helpers for IP geo location environment"
namespace :geoip do
  
  namespace :upgrade do
    
    desc "download new version of geoip db (previous db stored as '_GeoLiteCity.dat' file)"
    task :db => :environment do
      system('cd tmp && wget -N http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz')
      system('! test -d db/max_mind && mkdir db/max_mind')
      system('gzip -dfvN tmp/GeoLiteCity.dat.gz')
      system('test -f db/max_mind/GeoLiteCity.dat && cp db/max_mind/GeoLiteCity.dat db/max_mind/_GeoLiteCity.dat')
      system('mv -f tmp/GeoLiteCity.dat db/max_mind/GeoLiteCity.dat')
    end # end task
    
    desc "find undefined clicks and try find location"
    task :clicks => :environment do
      count = 0
      Click.find_all_by_located(false).each do |click|
        IpLocation.resolve_location_for click
        (click.save and count += 1) if click.located?
      end
      count > 0 ? puts("Updated %d records" % count) : puts("Nothing update")
    end
    
  end # end :upgrade namespace
end # end :geoip namespace