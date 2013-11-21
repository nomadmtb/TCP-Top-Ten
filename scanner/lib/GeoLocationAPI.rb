require 'open-uri'
require 'json'

class GeoLocationAPI

	def lookup(ip_address)
		request = "http://freegeoip.net/json/" + ip_address
		raw = open(request).readline
		location_data = JSON.parse(raw)
		return location_data
	end

end
