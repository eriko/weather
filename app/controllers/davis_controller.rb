class DavisController < ApplicationController
  # GET /davis
  # GET /davis.json
  def index
    @davis = Davi.order("recorded_datetime ASC").limit(50)
    if params[:davi]
    if params[:davi][:start_date] && params[:davi][:start_date].length >0
      @start_date = Chronic.parse params[:davi][:start_date]
    end
    if params[:davi][:end_date] && params[:davi][:end_date].length >0
      @end_date = Chronic.parse params[:davi][:end_date]
    end
    if @start_date && @end_date
      @davis = Davi.where("recorded_datetime >= ? AND recorded_datetime <= ?",@start_date,@end_date ).order("recorded_datetime ASC")
    else
      @davis = Davi.order("created_at").limit(20)
    end
    end
    @first = Davi.order("recorded_datetime ASC").limit(1)[0]
    @last = Davi.order("recorded_datetime DESC").limit(1)[0]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @davis }
      format.csv { render text: @davis.to_csv }
    end
  end

  # GET /davis/1
  # GET /davis/1.json
  def show
    @davi = Davi.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @davi }
    end
  end

  # GET /davis/new
  # GET /davis/new.json
  def new
    @davi = Davi.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @davi }
    end
  end

  # GET /davis/1/edit
  def edit
    @davi = Davi.find(params[:id])
  end

  # POST /davis
  # POST /davis.json
  def create
    @davi = Davi.new(davi_params)

    respond_to do |format|
      if @davi.save
        format.html { redirect_to @davi, notice: 'Davi was successfully created.' }
        format.json { render json: @davi, status: :created, location: @davi }
      else
        format.html { render action: "new" }
        format.json { render json: @davi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /davis/1
  # PATCH/PUT /davis/1.json
  def update
    @davi = Davi.find(params[:id])

    respond_to do |format|
      if @davi.update_attributes(davi_params)
        format.html { redirect_to @davi, notice: 'Davi was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @davi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /davis/1
  # DELETE /davis/1.json
  def destroy
    @davi = Davi.find(params[:id])
    @davi.destroy

    respond_to do |format|
      format.html { redirect_to davis_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def davi_params
      params.require(:davi).permit(:bp, :dp, :hot, :hws, :ih, :it, :lot, :oh, :ot, :r, :recorded_datetime, :wc, :wd, :ws)
    end
end
