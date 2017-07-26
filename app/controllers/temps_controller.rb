class TempsController < ApplicationController
  before_action :set_temp, only: [:show, :edit, :update, :destroy]

  # GET /temps
  def index
    @temps = Temp.all
  end

  # GET /temps/1
  def show
  end

  # GET /temps/new
  def new
    @temp = Temp.new
  end

  # GET /temps/1/edit
  def edit
  end

  # POST /temps
  def create
    @temp = Temp.new(temp_params)

    if @temp.save
      redirect_to loose_hashed_url(temp_path(@temp)), notice: 'Temp was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /temps/1
  def update
    if @temp.update(temp_params)
      redirect_to loose_hashed_url(temp_path(@temp)), notice: 'Temp was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /temps/1
  def destroy
    @temp.destroy
    redirect_to loose_hashed_url(temps_url), notice: 'Temp was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp
      @temp = Temp.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def temp_params
      params.require(:temp).permit(:place_id, :temp_on, :average, :max, :min)
    end
end
