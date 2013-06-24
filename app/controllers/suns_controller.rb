class SunsController < ApplicationController
  # GET /suns
  # GET /suns.json
  def index
    @suns = Sun.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @suns }
    end
  end

  # GET /suns/1
  # GET /suns/1.json
  def show
    @sun = Sun.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sun }
    end
  end

  # GET /suns/new
  # GET /suns/new.json
  def new
    @sun = Sun.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sun }
    end
  end

  # GET /suns/1/edit
  def edit
    @sun = Sun.find(params[:id])
  end

  # POST /suns
  # POST /suns.json
  def create
    @sun = Sun.new(sun_params)

    respond_to do |format|
      if @sun.save
        format.html { redirect_to @sun, notice: 'Sun was successfully created.' }
        format.json { render json: @sun, status: :created, location: @sun }
      else
        format.html { render action: "new" }
        format.json { render json: @sun.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suns/1
  # PATCH/PUT /suns/1.json
  def update
    @sun = Sun.find(params[:id])

    respond_to do |format|
      if @sun.update_attributes(sun_params)
        format.html { redirect_to @sun, notice: 'Sun was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sun.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suns/1
  # DELETE /suns/1.json
  def destroy
    @sun = Sun.find(params[:id])
    @sun.destroy

    respond_to do |format|
      format.html { redirect_to suns_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def sun_params
      params.require(:sun).permit(:rise, :set)
    end
end
