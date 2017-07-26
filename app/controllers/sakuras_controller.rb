class SakurasController < ApplicationController
  before_action :set_sakura, only: [:show, :edit, :update, :destroy]

  # GET /sakuras
  def index
    @sakuras = Sakura.all
  end

  # GET /sakuras/1
  def show
  end

  # GET /sakuras/new
  def new
    @sakura = Sakura.new
  end

  # GET /sakuras/1/edit
  def edit
  end

  # POST /sakuras
  def create
    @sakura = Sakura.new(sakura_params)

    if @sakura.save
      redirect_to loose_hashed_url(sakura_path(@sakura)), notice: 'Sakura was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sakuras/1
  def update
    if @sakura.update(sakura_params)
      redirect_to loose_hashed_url(sakura_path(@sakura)), notice: 'Sakura was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sakuras/1
  def destroy
    @sakura.destroy
    redirect_to loose_hashed_url(sakuras_url), notice: 'Sakura was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sakura
      @sakura = Sakura.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sakura_params
      params.require(:sakura).permit(:place_id, :year, :open_at, :full_at)
    end
end
