class OpenPortsController < ApplicationController
  before_action :set_open_port, only: [:show, :edit, :update, :destroy]

  # GET /open_ports
  # GET /open_ports.json
  def index
    @open_ports = OpenPort.all
  end

  # GET /open_ports/1
  # GET /open_ports/1.json
  def show
  end

  # GET /open_ports/new
  def new
    @open_port = OpenPort.new
  end

  # GET /open_ports/1/edit
  def edit
  end

  # POST /open_ports
  # POST /open_ports.json
  def create
    @open_port = OpenPort.new(open_port_params)

    respond_to do |format|
      if @open_port.save
        format.html { redirect_to @open_port, notice: 'Open port was successfully created.' }
        format.json { render action: 'show', status: :created, location: @open_port }
      else
        format.html { render action: 'new' }
        format.json { render json: @open_port.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /open_ports/1
  # PATCH/PUT /open_ports/1.json
  def update
    respond_to do |format|
      if @open_port.update(open_port_params)
        format.html { redirect_to @open_port, notice: 'Open port was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @open_port.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /open_ports/1
  # DELETE /open_ports/1.json
  def destroy
    @open_port.destroy
    respond_to do |format|
      format.html { redirect_to open_ports_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_open_port
      @open_port = OpenPort.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def open_port_params
      params.require(:open_port).permit(:scan_id, :port, :service)
    end
end
