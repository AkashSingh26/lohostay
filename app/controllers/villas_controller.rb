class VillasController < ApplicationController
  before_action :set_villa, only: %i[ show edit update destroy show_results ]

  def index
   @villas = Villa.all
  end

  def search
    redirect_to search_results_villas_path(start_date: params[:start_date], end_date: params[:end_date])
  end

  def search_results
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    sort_by = params[:sort_by] || 'price'

    @villas = Villa.search_results(start_date, end_date, sort_by)
  end

  def show_results
    @start_date = params[:start_date]
    @end_date = params[:end_date]

    if @start_date.present? && @end_date.present?
      @availability = @villa.available_for_dates?(Date.parse(@start_date), Date.parse(@end_date))
      @total_price = @villa.calculate_total_price(Date.parse(@start_date), Date.parse(@end_date)) if @availability
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
    params.require(:villa).permit(:name, images: [])
  end
end
