# This will be used to check for valid ip addresses.
# IP Form: 255.255.255.255
# Reserved:
# 	10.0.0.0    -> 10.255.255.255
# 	172.16.0.0  -> 172.31.255.255
# 	192.168.0.0 -> 192.168.255.255

def valid_ip? address

	# Basic IP Check.
	if address =~ /[0-255]\.[0-255]\.[0-255]\.[0-255]/
		return true
	else
		return false
	end

end
