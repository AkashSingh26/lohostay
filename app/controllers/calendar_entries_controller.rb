class CalendarEntriesController < ApplicationController
  before_action :set_calendar_entry, only: %i[ show edit update destroy ]

  # GET /calendar_entries or /calendar_entries.json
  def index
    @calendar_entries = CalendarEntry.all
  end

  # GET /calendar_entries/1 or /calendar_entries/1.json
  def show
  end

  # GET /calendar_entries/new
  def new
    @calendar_entry = CalendarEntry.new
  end

  # GET /calendar_entries/1/edit
  def edit
  end

  # POST /calendar_entries or /calendar_entries.json
  def create
    @calendar_entry = CalendarEntry.new(calendar_entry_params)

    respond_to do |format|
      if @calendar_entry.save
        format.html { redirect_to calendar_entry_url(@calendar_entry), notice: I18n.t('created_successfully') }
        format.json { render :show, status: :created, location: @calendar_entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @calendar_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calendar_entries/1 or /calendar_entries/1.json
  def update
    respond_to do |format|
      if @calendar_entry.update(calendar_entry_params)
        format.html { redirect_to calendar_entry_url(@calendar_entry), notice: I18n.t('updated_successfully') }
        format.json { render :show, status: :ok, location: @calendar_entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @calendar_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendar_entries/1 or /calendar_entries/1.json
  def destroy
    @calendar_entry.destroy!

    respond_to do |format|
      format.html { redirect_to calendar_entries_url,notice: I18n.t('destroyed_successfully') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar_entry
      @calendar_entry = CalendarEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def calendar_entry_params
      params.require(:calendar_entry).permit(:villa_id, :date, :price, :available)
    end
end
