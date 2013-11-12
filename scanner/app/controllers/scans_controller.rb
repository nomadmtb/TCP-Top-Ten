require 'NomadScanAPI'

class ScansController < ApplicationController
  before_action :set_scan, only: [:show, :edit, :update, :destroy]

  # GET /scans
  # GET /scans.json
  def index
    @scans = Scan.all
  end

  # GET /scans/1
  # GET /scans/1.json
  def show
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

    #@scan = Scan.new(scan_params)
    #@scan.set_scan_results
    
    @user = current_user
    @scan = @user.scans.create(scan_params)
    @scan.set_scan_results
    ports = @scan.get_ports
    puts ports

    ports.each do |key, value|
	    port = key
	    service = value
	    open_port_params = [port, service]
	    @scan.open_ports.create(:port => key, :service =>value)
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
