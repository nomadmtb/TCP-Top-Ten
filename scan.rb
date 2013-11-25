#!/usr/bin/env ruby

require 'rexml/document'
require 'yaml'
include REXML

if !ARGV[0].include? ';'

	#needed to redirect stderr to stdout to detect hostname problems
	scan_raw = `nmap #{ARGV[0]} -R -PN --open --top-ports 10 -sT -oX - 2>&1`
	if !scan_raw.include? "Failed to resolve given hostname/IP"
		scan_hash = Hash.new()
		port_hash = Hash.new()
		doc = (Document.new scan_raw).root

		#scan time
		elapsed = doc.elements.to_a("//finished")

		#hostname...
		hostname = doc.elements.to_a("//hostname")
		
		#parsing for ports...
		ports = doc.elements.to_a("//port")
	
		#parsing for services...
		services = doc.elements.to_a("//service")
	
		#parsing for status...
		status = doc.elements.to_a("//status")

		#parsing for ip address...
		ip_address = doc.elements.to_a("//address")
	
		#merging parallel arrays into a single key/value hash...
		scan_hash.merge!('raw' => scan_raw)
		scan_hash.merge!('elapsed' => elapsed[0].attributes["elapsed"])
		scan_hash.merge!('ip_address' => ip_address[0].attributes["addr"])
		scan_hash.merge!('status' => status[0].attributes["state"])
		if hostname.empty?
			scan_hash.merge!('hostname' => 'No Reverse DNS Record Available')
		else
			scan_hash.merge!('hostname' => hostname[0].attributes["name"])
		end
		(0...ports.length).each{|i| port_hash.merge!({ports[i].attributes["portid"] => services[i].attributes["name"]})}
		scan_hash.merge!('open_ports' => port_hash);
	
		puts scan_hash.to_yaml
	else
		puts "API ERROR"
	end
else
	puts "Input ERROR."
end
