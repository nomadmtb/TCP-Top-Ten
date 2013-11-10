require 'open-uri'

class NomadScanAPI

	def scan(ip_address)
		request = "http://api.nomadmtb.com?ip=" + ip_address

		scan_data = open(request)

		return scan_data
	end
end
