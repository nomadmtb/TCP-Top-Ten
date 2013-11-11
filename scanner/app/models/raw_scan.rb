class RawScan < ActiveRecord::Base

  # Raw_scan belongs to a scan object.
  belongs_to :scan

end
