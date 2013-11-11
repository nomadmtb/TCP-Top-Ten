class OpenPort < ActiveRecord::Base

  # Open ports belong to a scan.
  belongs_to :scan

end
