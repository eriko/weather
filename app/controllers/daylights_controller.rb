class DaylightsController < ApplicationController
  # GET /daylights
  # GET /daylights.json
  def index
    @daylights = Daylight.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @daylights }
    end
  end

  # GET /daylights/1
  # GET /daylights/1.json
  def show
    @daylight = Daylight.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @daylight }
    end
  end

  # GET /daylights/new
  # GET /daylights/new.json
  def new
    @daylight = Daylight.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @daylight }
    end
  end

  # GET /daylights/1/edit
  def edit
    @daylight = Daylight.find(params[:id])
  end

  # POST /daylights
  # POST /daylights.json
  def create
    @daylight = Daylight.new(daylight_params)

    respond_to do |format|
      if @daylight.save
        format.html { redirect_to @daylight, notice: 'Daylight was successfully created.' }
        format.json { render json: @daylight, status: :created, location: @daylight }
      else
        format.html { render action: "new" }
        format.json { render json: @daylight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daylights/1
  # PATCH/PUT /daylights/1.json
  def update
    @daylight = Daylight.find(params[:id])

    respond_to do |format|
      if @daylight.update_attributes(daylight_params)
        format.html { redirect_to @daylight, notice: 'Daylight was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @daylight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daylights/1
  # DELETE /daylights/1.json
  def destroy
    @daylight = Daylight.find(params[:id])
    @daylight.destroy

    respond_to do |format|
      format.html { redirect_to daylights_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def daylight_params
      params.require(:daylight).permit(:start, :stop)
    end
end
