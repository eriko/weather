class DavisesController < ApplicationController
  # GET /davises
  # GET /davises.json
  def index
    @davises = Davis.order("recorded_datetime ASC").limit(50)
    if params[:davis]
    if params[:davis][:start_date] && params[:davis][:start_date].length >0
      @start_date = Chronic.parse params[:davis][:start_date]
    end
    if params[:davis][:end_date] && params[:davis][:end_date].length >0
      @end_date = Chronic.parse params[:davis][:end_date]
    end
    if @start_date && @end_date
      @davis = Davis.where("recorded_datetime >= ? AND recorded_datetime <= ?",@start_date,@end_date ).order("recorded_datetime ASC")
    else
      @davis = Davis.order("created_at").limit(20)
    end
    end
    @first = Davis.order("recorded_datetime ASC").limit(1)[0]
    @last = Davis.order("recorded_datetime DESC").limit(1)[0]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @davis }
      format.csv { render text: @davis.to_csv }
    end
  end

  # GET /davises/1
  # GET /davises/1.json
  def show
    redirect_to action: "latest"
    @davis = Davis.find(params[:id])

    #respond_to do |format|
    #  format.html # show.html.erb
    #  format.json { render json: @davis }
    #end
  end

  # GET /davises/new
  # GET /davises/new.json
  def new
    redirect_to action: "latest"
    @davis = Davis.new

    #respond_to do |format|
    #  format.html # new.html.erb
    #  format.json { render json: @davis }
    #end
  end

  # GET /davises/1/edit
  def edit
    redirect_to action: "latest"
    #@davis = Davis.find(params[:id])
  end

  # POST /davises
  # POST /davises.json
  def create
    redirect_to action: "latest"
    #@davis = Davis.new(davi_params)

    #respond_to do |format|
    #  if @davis.save
    #    format.html { redirect_to @davis, notice: 'Davis was successfully created.' }
    #    format.json { render json: @davis, status: :created, location: @davis }
    #  else
    #    format.html { render action: "new" }
    #    format.json { render json: @davis.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /davises/1
  # PATCH/PUT /davises/1.json
  def update
    redirect_to action: "latest"
    @davis = Davis.find(params[:id])

    #respond_to do |format|
    #  if @davis.update_attributes(davi_params)
    #    format.html { redirect_to @davis, notice: 'Davis was successfully updated.' }
    #    format.json { head :no_content }
    #  else
    #    format.html { render action: "edit" }
    #    format.json { render json: @davis.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /davises/1
  # DELETE /davises/1.json
  def destroy
    redirect_to action: "latest"
    @davis = Davis.find(params[:id])
    @davis.destroy

    #respond_to do |format|
    #  format.html { redirect_to davis_url }
    #  format.json { head :no_content }
    #end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def davi_params
      params.require(:davi).permit(:bp, :dp, :hot, :hws, :ih, :it, :lot, :oh, :ot, :r, :recorded_datetime, :wc, :wd, :ws)
    end
end
