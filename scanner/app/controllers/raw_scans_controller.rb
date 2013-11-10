class RawScansController < ApplicationController
  before_action :set_raw_scan, only: [:show, :edit, :update, :destroy]

  # GET /raw_scans
  # GET /raw_scans.json
  def index
    @raw_scans = RawScan.all
  end

  # GET /raw_scans/1
  # GET /raw_scans/1.json
  def show
  end

  # GET /raw_scans/new
  def new
    @raw_scan = RawScan.new
  end

  # GET /raw_scans/1/edit
  def edit
  end

  # POST /raw_scans
  # POST /raw_scans.json
  def create
    @raw_scan = RawScan.new(raw_scan_params)

    respond_to do |format|
      if @raw_scan.save
        format.html { redirect_to @raw_scan, notice: 'Raw scan was successfully created.' }
        format.json { render action: 'show', status: :created, location: @raw_scan }
      else
        format.html { render action: 'new' }
        format.json { render json: @raw_scan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /raw_scans/1
  # PATCH/PUT /raw_scans/1.json
  def update
    respond_to do |format|
      if @raw_scan.update(raw_scan_params)
        format.html { redirect_to @raw_scan, notice: 'Raw scan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @raw_scan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /raw_scans/1
  # DELETE /raw_scans/1.json
  def destroy
    @raw_scan.destroy
    respond_to do |format|
      format.html { redirect_to raw_scans_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raw_scan
      @raw_scan = RawScan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def raw_scan_params
      params.require(:raw_scan).permit(:scan_id, :raw_xml)
    end
end
