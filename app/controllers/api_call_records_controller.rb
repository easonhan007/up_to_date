class ApiCallRecordsController < ApplicationController
  before_action :set_api_call_record, only: %i[ show edit update destroy ]

  # GET /api_call_records or /api_call_records.json
  def index
    @pagy, @api_call_records = pagy ApiCallRecord.order('created_at DESC').all
  end

  # GET /api_call_records/1 or /api_call_records/1.json
  def show
  end

  # GET /api_call_records/new
  def new
    @api_call_record = ApiCallRecord.new
  end

  # GET /api_call_records/1/edit
  def edit
  end

  # POST /api_call_records or /api_call_records.json
  def create
    @api_call_record = ApiCallRecord.new(api_call_record_params)

    if @api_call_record.save
      @api_call_record.call_api()
      flash[:now] = "Successfully create api records"
    else
      flash[:now] = "Can not create api record"
    end

  end

  # PATCH/PUT /api_call_records/1 or /api_call_records/1.json
  def update
    respond_to do |format|
      if @api_call_record.update(api_call_record_params)
        format.html { redirect_to api_call_record_url(@api_call_record), notice: "Api call record was successfully updated." }
        format.json { render :show, status: :ok, location: @api_call_record }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @api_call_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api_call_records/1 or /api_call_records/1.json
  def destroy
    @api_call_record.destroy!

    respond_to do |format|
      format.html { redirect_to api_call_records_url, notice: "Api call record was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_call_record
      @api_call_record = ApiCallRecord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_call_record_params
      params.require(:api_call_record).permit(:post_id, :post_target_id, :status_code, :log, :user_id)
    end
end
