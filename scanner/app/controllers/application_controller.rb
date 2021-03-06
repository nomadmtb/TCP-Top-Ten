class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def check_user?
	  if !current_user
		  redirect_to root_path, :alert => 'Please sign-in(up) to continue'
	  end
  end

  def host_count
	  scan_count = Scan.distinct.count()
	  respond_to do |format|
		  msg = {:count => scan_count}
		  format.json { render :json => msg }
	  end
  end

  def recent_locations
	  locations = Array.new

	  scans = Scan.limit(100)

	  scans.each do |scan|
		  coords = Hash.new
		  coords = {:latitude => scan.latitude, :longitude => scan.longitude, :location => scan_path(scan), :ip_address => scan.ip_address}
		  locations.push(coords)
	  end

	  locations.uniq!

	  respond_to do |format|
		  format.json { render :json => locations }
	  end
  end

end
