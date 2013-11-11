require 'NomadScanAPI'

class Scan < ActiveRecord::Base

  #Scans belong to a user. If a scan is deleted, then all
  #the associated data is too.

  belongs_to :user
  has_one :raw_scan
  has_many :open_ports, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  accepts_nested_attributes_for :open_ports, :raw_scan, :comments

  def set_scan_results

	  api = NomadScanAPI.new
	  results = api.scan(self.ip_address)

	  if results != false
		  self.scan_date = DateTime.now
		  self.status = results['status']
		  self.elapsed = results['elapsed']
		  self.domain_name_ptr = results['hostnames'].first
	  end
  end

end
