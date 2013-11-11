class Scan < ActiveRecord::Base

  #Scans belong to a user. If a scan is deleted, then all
  #the associated data is too.

  belongs_to :user
  has_many :open_ports, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  accepts_nested_attributes_for :open_ports, :raw_scan, :comments

end
