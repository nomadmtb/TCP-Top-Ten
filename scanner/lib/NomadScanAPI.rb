require 'open-uri'
require 'yaml'

class NomadScanAPI

	def scan(ip_address)
		request = "http://api.nomadmtb.com?ip=" + ip_address
		scan_data = open(request)
		scan_data = YAML.load(scan_data)
		return scan_data
	end
end
