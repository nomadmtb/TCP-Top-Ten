require 'NomadScanAPI'

class ScansController < ApplicationController
  before_action :set_scan, only: [:show, :edit, :update, :destroy]
  before_action :check_user?

  # GET /scans
  # GET /scans.json
  def index
    @scans = Scan.all
  end

  def myscans
	  @scans = Scan.find(:all, :conditions => ["user_id = ?", current_user.id])
  end

  def search
	  if params[:query].empty?
		  redirect_to root_path, :alert => 'Your search string was empty'
	  else
		if params[:query].index('Port: ') == 0
			command = params[:query].split(': ')
			if !command[1].empty?
				port = command[1]

				scans = Scan.all
				@results = Array.new

				scans.each do |scan|
					scan.open_ports.each do |open_port|
						if open_port.port.to_s == port
							@results.push(open_port.scan)
						end
					end
				end

				render "command_search"
			else
				redirect_to root_path, :alert => 'Command Error'
			end
		else
	  		scans = Scan.all
	  		@scans_ip = scans.map { |x| x if x.ip_address =~ /#{Regexp.quote(params[:query])}/ }.compact
	  		@scans_dns = scans.map { |x| x if x.domain_name_ptr =~ /#{Regexp.quote(params[:query])}/i }.compact
  	  	end
  	end
  end

  def download
	  @scan = Scan.find(params[:id])
	  send_data(@scan.xml, :filename => "scan_data.xml")
  end

  # GET /scans/1
  # GET /scans/1.json
  def show
  end

  # GET /scans/stats
  def stats
    @host_count = Scan.count
    @port_count = OpenPort.count
    @ports_per_host = (@port_count/@host_count.to_f).round(4)

    @ftp_num = OpenPort.count(:all, :conditions => ['port = ?', 21])
    @ftp_percent = ((@ftp_num/@host_count.to_f)*100).round(4).to_s + ' %'

    @ssh_num = OpenPort.count(:all, :conditions => ['port = ?', 22])
    @ssh_percent = ((@ssh_num/@host_count.to_f)*100).round(4).to_s + ' %'

    @telnet_num = OpenPort.count(:all, :conditions => ['port = ?', 23])
    @telnet_percent = ((@telnet_num/@host_count.to_f)*100).round(4).to_s + ' %'

    @smtp_num = OpenPort.count(:all, :conditions => ['port = ?', 25])
    @smtp_percent = ((@smtp_num/@host_count.to_f)*100).round(4).to_s + ' %'
    
    @http_num = OpenPort.count(:all, :conditions => ['port = ?', 80])
    @http_percent = ((@http_num/@host_count.to_f)*100).round(4).to_s + ' %'

    @pop3_num = OpenPort.count(:all, :conditions => ['port = ?', 110])
    @pop3_percent = ((@pop3_num/@host_count.to_f)*100).round(4).to_s + ' %'

    @netbios_num = OpenPort.count(:all, :conditions => ['port = ?', 139])
    @netbios_percent = ((@netbios_num/@host_count.to_f)*100).round(4).to_s + ' %'

    @https_num = OpenPort.count(:all, :conditions => ['port = ?', 443])
    @https_percent = ((@https_num/@host_count.to_f)*100).round(4).to_s + ' %'

    @smb_num = OpenPort.count(:all, :conditions => ['port = ?', 445])
    @smb_percent = ((@smb_num/@host_count.to_f)*100).round(4).to_s + ' %'

    @rdp_num = OpenPort.count(:all, :conditions => ['port = ?', 3389])
    @rdp_percent = ((@rdp_num/@host_count.to_f)*100).round(4).to_s + ' %'
  end

  # GET /scans/new
  def new
    @scan = Scan.new
  end

  # GET /scans/1/edit
  def edit
  end

  # POST /scans
  # POST /scans.json
  def create
 
    # Getting current user object	  
    @user = current_user
    # Creating an empty scan object
    @scan = @user.scans.create(scan_params)

    # Only do API stuff if create didn't add any errors to @scan
    if !@scan.errors.any?
    	# Requesting API and setting data
    	@scan.set_scan_results
    	# Getting non-persistent open ports.
    	ports = @scan.get_ports

    	# Looping through hash of open ports, and
    	# creating an open_port object that belongs
    	# to the scan object.
    	ports.each do |key, value|
	    	port = key
	    	service = value
	    	open_port_params = [port, service]
	    	@scan.open_ports.create(:port => key, :service => value)
    	end
    end

    respond_to do |format|
      if @scan.save
        format.html { redirect_to @scan, notice: 'Scan was successfully created.' }
        format.json { render action: 'show', status: :created, location: @scan }
      else
        format.html { render action: 'new' }
        format.json { render json: @scan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scans/1
  # PATCH/PUT /scans/1.json
  def update
    respond_to do |format|
      if @scan.update(scan_params)
        format.html { redirect_to @scan, notice: 'Scan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @scan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scans/1
  # DELETE /scans/1.json
  def destroy
    @scan.destroy
    respond_to do |format|
      format.html { redirect_to scans_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scan
      @scan = Scan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scan_params
      params.require(:scan).permit(:ip_address)
    end
end
