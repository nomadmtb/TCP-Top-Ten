require 'NomadScanAPI'
require 'GeoLocationAPI'

class Scan < ActiveRecord::Base

  #Scans belong to a user. If a scan is deleted, then all
  #the associated data is too.

  belongs_to :user
  has_many :open_ports, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  attr_accessor :get_ports

  accepts_nested_attributes_for :open_ports, :comments

  def set_scan_results

	  api = NomadScanAPI.new
	  results = api.scan(self.ip_address)

	  if results != false
		  self.get_ports = results['open_ports']
		  self.scan_date = DateTime.now
		  self.xml = results['raw']
		  self.status = results['status']
		  self.elapsed = results['elapsed']
		  self.domain_name_ptr = results['hostname']

		  set_geolocation
	  end
  end

  def set_geolocation

	  api = GeoLocationAPI.new
	  results = api.lookup(self.ip_address)
	  self.latitude = results['latitude']
	  self.longitude = results['longitude']

  end

end
