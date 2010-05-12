require 'benchmark'
require 'net/geoip'

# ruby -I"lib" lib/net/geoip_benchmark.rb

# geoip = Net::GeoIP.new 'db/max_mind/GeoLiteCity.dat'
# n = 100
# Benchmark.bmbm(8) do |x|
#   x.report("79.171.120.0") { for i in 1..n; geoip["79.171.120.0"]; end }
#   x.report("80.91.181.131") { for i in 1..n; geoip["80.91.181.131"]; end }
#   x.report("77.88.216.22") { for i in 1..n; geoip["77.88.216.22"]; end }
# end

geoip = Net::GeoIP.new('db/max_mind/GeoLiteCity.dat')
n = 10
Benchmark.bmbm(8) do |x|
  x.report("79.171.120.0") { for i in 1..n; Net::GeoIP.new('db/max_mind/GeoLiteCity.dat')["79.171.120.0"]; end }
  x.report("80.91.181.131") { for i in 1..n; geoip["80.91.181.131"]; end }
end