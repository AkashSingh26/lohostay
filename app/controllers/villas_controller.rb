class VillasController < ApplicationController
  before_action :set_villa, only: %i[ show edit update destroy ]

  def index
   @villas = Villa.all
  end

  def search
    start_date = params[:start_date]
    end_date = params[:end_date]

    redirect_to search_results_villas_path(start_date: start_date, end_date: end_date)
  end

  def search_results
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    villas = Villa.includes(:calendar_entries).all

    @villas = []
    villas.select do |villa|
      entries = villa.calendar_entries.where(date: start_date...end_date)
      if entries.all?(&:available)
        average_price = entries.average(:price).to_f
        @villas <<{
          name: villa.name,
          average_price_per_night: average_price,
          availability: true
        }
      end
    end
  end

  def show
  end

  # GET /villas/new
  def new
    @villa = Villa.new
  end

  # GET /villas/1/edit
  def edit
  end

  # POST /villas or /villas.json
  def create
    @villa = Villa.new(villa_params)

    respond_to do |format|
      if @villa.save
        format.html { redirect_to villa_url(@villa), notice: "Villa was successfully created." }
        format.json { render :show, status: :created, location: @villa }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @villa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /villas/1 or /villas/1.json
  def update
    respond_to do |format|
      if @villa.update(villa_params)
        format.html { redirect_to villa_url(@villa), notice: "Villa was successfully updated." }
        format.json { render :show, status: :ok, location: @villa }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @villa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /villas/1 or /villas/1.json
  def destroy
    @villa.destroy!

    respond_to do |format|
      format.html { redirect_to villas_url, notice: "Villa was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_villa
    @villa = Villa.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def villa_params
    params.require(:villa).permit(:name)
  end
end
