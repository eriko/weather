class CampbelsController < ApplicationController

  def latest
    @campbels = Campbel.order("created_at").limit(20)


    if @standard
      @temp_upper = 88
      @wind_upper = 88
      @rain_upper = 0.5
    else
      @temp_upper = 30
      @wind_upper = 25
      @rain_upper = 12
    end
    @last_record = Campbel.last
    @columns = [:timestamp, :record_num, :air_temp_c_avg, :air_temp_c_max, :air_temp_c_min, :rel_hum_avg, :rel_hum_max, :rel_hum_min, :wind_speed_ms_max, :wind_speed_avg, :wind_dir_avg, :solar_rad_w_avg, :solar_rad_w_max, :rain_mm_total, :dew_point_c_max, :dew_point_c_min, :wind_chill_c_max, :wind_chill_c_min, :heat_index_c_max, :heat_index_c_min, :etrs_mm_total, :rso]
    #@graph = open_flash_chart_object(600,300, '/weather/weather/today_temp', true, '/weather/')
    @last = Campbel.last_x_hours(24, @last_record)
    @last_24 =[]
    @last.each do |record|
      @last_24 << record
    end
    @last = Campbel.last_x_hours(6, @last_record)
    @last_6 = []
    @last.each do |record|
      @last_6 << record
    end
    @sun = SolarEventCalculator.new(Date.new(Time.now.year, Time.now.month, Time.now.day), 47.073511, -122.970878)
    @sunrise = @sun.compute_utc_official_sunrise()
    @sunset = @sun.compute_utc_official_sunset()
    #@sunrise = Sun.find(:first ,  :conditions => ["suns.rise >= ? and suns.set <= ?",DateTime.now(),DateTime.now()+1])
    @dst = Daylight.dst?(Time.now)
    @sunrise = @sunrise.new_offset(-8.0/24)
    @sunset = @sunset.new_offset(-8.0/24)

    @latest = Campbel.order(:timestamp).last

    @tides = Hash.new
    stations = Station.all
    stations.each do |station|
      @tides[station] = Prediction.where(date: (Time.now.midnight - 1.day)..Time.now.midnight, station_id: station)
    end


    respond_to do |format|
      format.html # index.html.erb
      format.xml #lastest.xml.erb
      format.json { render json: @campbels }
    end
  end

  def graph
    if params[:days]
      @campbels = Campbel.last_x_hours(24*(params[:days].to_i), Campbel.last)
    end
    if @campbels.length > 0 && params[:graph_name]

    end
    #@campbels  = Campbel.where("(timestamp >= '2013-06-22 15:00:00.000000' AND timestamp <= '2013-06-23 15:00:00.000000')").order("timestamp ASC")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @campbels.to_json(:only => [:id,:timestamp, :air_temp_c_avg , :air_temp_c_max , :air_temp_c_min]) }
      format.csv { render text: @campbels.to_csv }
    end
  end

  def wind
    if params[:format].eql?('json')
      @campbels = Campbel.where(timestamp: (Time.now.midnight - 2.year)..Time.now.midnight)
      @records = Hash.new
      data = Hash.new
      @records["data"] = data
      @campbels.each do |campbel|
        key = "#{campbel.timestamp.month}:#{ campbel.wind_dir_avg.round(-1)}"
        data[key] = data.has_key?(key) ? data[key] << campbel.wind_speed_avg : [campbel.wind_speed_avg]
      end
      data.each do |key, value|
        length = value.length
        total = 0
        value.each { |rec| total+=rec }
        data[key]= [length, (total/length).round(1)]
      end

      @records["info"] = [
          lat: 37.6169,
          lon: -122.3828,
          name: "The Evergreen State College",
          id: "KOLM"
      ]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @records }
    end
  end


  # GET /campbels
  # GET /campbels.json
  def index
    @campbels = Campbel.order("created_at").limit(20)
    if params[:campbel]
      if params[:campbel][:start_date] && params[:campbel][:start_date].length >0
        @start_date = Chronic.parse params[:campbel][:start_date]
      end
      if params[:campbel][:end_date] && params[:campbel][:end_date].length >0
        @end_date = Chronic.parse params[:campbel][:end_date]
      end
      if @start_date && @end_date
        @campbels = Campbel.where("timestamp >= ? AND timestamp <= ?", @start_date, @end_date).order("timestamp ASC")
      else
        @campbels = Campbel.order("created_at").limit(20)
      end
    end

    respond_to do |format|
      format.html # index.html.erb
                  #format.json { render json: @campbels }
      format.csv { render text: @campbels.to_csv }
    end
  end

  def about

    respond_to do |format|
      format.html # about.html.erb
    end
  end
  def evapotranspiration

    respond_to do |format|
      format.html # evapotranspiration.html.erb
    end
  end
  # GET /campbels/1
  # GET /campbels/1.json

  def show
    redirect_to action: "latest"
    @campbel = Campbel.find(params[:id])

    #respond_to do |format|
    #  format.html # show.html.erb
    #  format.json { render json: @campbel }
    #end
  end

  # GET /campbels/new
  # GET /campbels/new.json
  def new

    redirect_to action: "latest"
    @campbel = Campbel.new

    #respond_to do |format|
    #  format.html # new.html.erb
    #  format.json { render json: @campbel }
    #end
  end

  # GET /campbels/1/edit
  def edit

    redirect_to action: "latest"
    #@campbel = Campbel.find(params[:id])
  end

  # POST /campbels
  # POST /campbels.json
  def create

    redirect_to action: "latest"
    #@campbel = Campbel.new(campbel_params)

    #respond_to do |format|
    #  if @campbel.save
    #    format.html { redirect_to @campbel, notice: 'Campbel was successfully created.' }
    #    format.json { render json: @campbel, status: :created, location: @campbel }
    #  else
    #    format.html { render action: "new" }
    #    format.json { render json: @campbel.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /campbels/1
  # PATCH/PUT /campbels/1.json
  def update

    redirect_to action: "latest"
    @campbel = Campbel.find(params[:id])

    #respond_to do |format|
    #  if @campbel.update_attributes(campbel_params)
    #    format.html { redirect_to @campbel, notice: 'Campbel was successfully updated.' }
    #    format.json { head :no_content }
    #  else
    #    format.html { render action: "edit" }
    #    format.json { render json: @campbel.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /campbels/1
  # DELETE /campbels/1.json
  def destroy

    redirect_to action: "latest"
    @campbel = Campbel.find(params[:id])
    @campbel.destroy

    #respond_to do |format|
    #  format.html { redirect_to campbels_url }
    #  format.json { head :no_content }
    #end
  end

  private

  # Use this method to whitelist the permissible parameters. Example:
  # params.require(:person).permit(:name, :age)
  # Also, you can specialize this method with per-user checking of permissible attributes.
  def campbel_params
    params.require(:campbel).permit(:bp, :dp, :hot, :hws, :ih, :it, :lot, :oh, :ot, :r, :recorded_datetime, :wc, :wd, :ws)
  end
end
