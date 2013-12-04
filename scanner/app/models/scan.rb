require 'NomadScanAPI'
require 'GeoLocationAPI'
require 'ip_validate'

class Scan < ActiveRecord::Base

  belongs_to :user
  has_many :open_ports, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  attr_accessor :get_ports
  accepts_nested_attributes_for :open_ports, :comments
  validate :validate_ip

  def validate_ip
	  if !IpValidate.valid_ip? self.ip_address
		  errors.add :ip_address, "Not A Valid IP Address"
	  end
  end

  def set_scan_results
	  validate_ip

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
	  if results != false
	  	self.latitude = results['latitude']
	  	self.longitude = results['longitude']
	  else
		self.latitude = 0;
		self.longitude = 0;
	  end

  end

end
