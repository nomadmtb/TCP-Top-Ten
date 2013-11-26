# This will be used to check for valid ip addresses.
# IP Form: 255.255.255.255
# Reserved:
# 	10.0.0.0    -> 10.255.255.255
# 	172.16.0.0  -> 172.31.255.255
# 	192.168.0.0 -> 192.168.255.255

require 'ipaddr'

module IpValidate

def IpValidate.valid_ip? address
	begin
		addr = IPAddr.new(address)
	rescue
		return false
	else
		# Reserved IP ranges
		net1 = IPAddr.new("10.0.0.0/8")
		net2 = IPAddr.new("172.16.0.0/12")
		net3 = IPAddr.new("192.168.0.0/16")
		net4 = IPAddr.new("127.0.0.1")

		# Checking for broadcast address
		if address.include? '255'
			return false
		end
		if net1.include? addr
			return false
		end
		if net2.include? addr
			return false
		end
		if net3.include? addr
			return false
		end
		if net4.include? addr
			return false
		end

		return true
	end
end
end
