require 'rubygems'

## Calculate the distance between two coordinates using haversine method
## http://www.markhneedham.com/blog/2013/06/30/ruby-calculating-the-orthodromic-distance-using-the-haversine-formula/
def haversine(lat1, long1, lat2, long2)  
  radius_of_earth = 6378.14 
  rlat1, rlong1, rlat2, rlong2 = [lat1, long1, lat2, long2].map { |d| as_radians(d)}
 
  dlon = rlong1 - rlong2
  dlat = rlat1 - rlat2
 
  a = power(Math::sin(dlat/2), 2) + Math::cos(rlat1) * Math::cos(rlat2) * power(Math::sin(dlon/2), 2)
  great_circle_distance = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
  radius_of_earth * great_circle_distance
end
 
def as_radians(degrees)
  degrees * Math::PI/180
end
 
def power(num, pow)
  num ** pow
end


distance = haversine(-22.879968, -43.131665, -22.873949, -43.205800)  

puts distance