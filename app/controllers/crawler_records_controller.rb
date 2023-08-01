class CrawlerRecordsController < ApplicationController
  before_action :set_crawler_record, only: %i[ show edit update destroy ]

  # GET /crawler_records or /crawler_records.json
  def index
    @crawler_records = CrawlerRecord.all
  end

  # GET /crawler_records/1 or /crawler_records/1.json
  def show
  end

  # GET /crawler_records/new
  def new
    @crawler_record = CrawlerRecord.new
  end

  # GET /crawler_records/1/edit
  def edit
  end

  # POST /crawler_records or /crawler_records.json
  def create
    @crawler_record = CrawlerRecord.new(crawler_record_params)

    respond_to do |format|
      if @crawler_record.save
        format.html { redirect_to crawler_record_url(@crawler_record), notice: "Crawler record was successfully created." }
        format.json { render :show, status: :created, location: @crawler_record }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @crawler_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crawler_records/1 or /crawler_records/1.json
  def update
    respond_to do |format|
      if @crawler_record.update(crawler_record_params)
        format.html { redirect_to crawler_record_url(@crawler_record), notice: "Crawler record was successfully updated." }
        format.json { render :show, status: :ok, location: @crawler_record }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @crawler_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crawler_records/1 or /crawler_records/1.json
  def destroy
    @crawler_record.destroy

    respond_to do |format|
      format.html { redirect_to crawler_records_url, notice: "Crawler record was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crawler_record
      @crawler_record = CrawlerRecord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def crawler_record_params
      params.require(:crawler_record).permit(:url_count, :success, :failed, :urls, :crawler_setting_id)
    end
end
