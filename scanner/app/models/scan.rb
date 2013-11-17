require 'NomadScanAPI'
require 'open-uri'

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
		  self.xml = URI.unescape(results['raw'])
		  self.status = results['status']
		  self.elapsed = results['elapsed']
		  self.domain_name_ptr = results['hostnames'].first

		  if self.domain_name_ptr.empty?
			  self.domain_name_ptr == 'None'
		  end
	  end
  end

end
