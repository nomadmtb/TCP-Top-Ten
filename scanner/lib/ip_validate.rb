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
		net4 = IPAddr.new("127.0.0.0/8")
		net5 = IPAddr.new("0.0.0.0/8")
		net6 = IPAddr.new("169.254.0.0/16")
		net7 = IPAddr.new("192.0.2.0/24")
		net8 = IPAddr.new("198.51.100.0/24")
		net9 = IPAddr.new("203.0.113.0/24")
		net10 = IPAddr.new("192.88.99.0/24")
		net11 = IPAddr.new("198.18.0.0/15")
		net12 = IPAddr.new("224.0.0.0/4")
		net13 = IPAddr.new("255.255.255.255/32")

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
		if net5.include? addr
			return false
		end
		if net6.include? addr
			return false
		end
		if net7.include? addr
			return false
		end
		if net8.include? addr
			return false
		end
		if net9.include? addr
			return false
		end
		if net10.include? addr
			return false
		end
		if net11.include? addr
			return false
		end
		if net12.include? addr
			return false
		end
		if net13.include? addr
			return false
		end

		return true
	end
end
end
