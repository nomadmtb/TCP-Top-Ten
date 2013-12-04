require 'open-uri'
require 'json'

class GeoLocationAPI

	def lookup(ip_address)
		begin
			request = "http://freegeoip.net/json/" + ip_address
			raw = open(request).readline
			location_data = JSON.parse(raw)
			return location_data
		rescue
			return false
		end
	end

end
