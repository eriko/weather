class StationsController < ApplicationController
  # GET /stations
  # GET /stations.json
  def index
    @stations = Station.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stations }
    end
  end

  # GET /stations/1
  # GET /stations/1.json
  def show
    @station = Station.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @station }
    end
  end

  # GET /stations/new
  # GET /stations/new.json
  def new
    @station = Station.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @station }
    end
  end

  # GET /stations/1/edit
  def edit
    @station = Station.find(params[:id])
  end

  # POST /stations
  # POST /stations.json
  def create
    @station = Station.new(station_params)

    respond_to do |format|
      if @station.save
        format.html { redirect_to @station, notice: 'Station was successfully created.' }
        format.json { render json: @station, status: :created, location: @station }
      else
        format.html { render action: "new" }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stations/1
  # PATCH/PUT /stations/1.json
  def update
    @station = Station.find(params[:id])

    respond_to do |format|
      if @station.update_attributes(station_params)
        format.html { redirect_to @station, notice: 'Station was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stations/1
  # DELETE /stations/1.json
  def destroy
    @station = Station.find(params[:id])
    @station.destroy

    respond_to do |format|
      format.html { redirect_to stations_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def station_params
      params.require(:station).permit(:description, :height_high, :height_low, :longname, :name, :parent_id, :time_high, :time_low, :url)
    end
end
