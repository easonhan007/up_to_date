class CrawlerSettingsController < ApplicationController
  before_action :set_crawler_setting, only: %i[ show edit update destroy scrape ]

  # GET /crawler_settings or /crawler_settings.json
  def index
    @pagy, @crawler_settings = pagy current_user.crawler_settings.includes(:category).order('active ASC').order('created_at DESC').all
  end

  # GET /crawler_settings/1 or /crawler_settings/1.json
  def show
    @title = @crawler_setting.name
    @pagy, @posts = pagy Post.includes(:crawler_setting).where(crawler_setting_id: @crawler_setting.id).order('updated_at DESC')
  end

  # GET /crawler_settings/new
  def new
    if params[:from]
      @setting = CrawlerSetting.find(params[:from])
      @crawler_setting = CrawlerSetting.new
      %w(index_page_css detail_page_title_css detail_page_content_css detail_page_clean_up_css).each do |field|
        @crawler_setting.send(field + "=", @setting.send(field))
      end
    else
      @crawler_setting = CrawlerSetting.new
    end #if
  end

  # GET /crawler_settings/1/edit
  def edit
  end

  # POST /crawler_settings or /crawler_settings.json
  def create
    @crawler_setting = CrawlerSetting.new(crawler_setting_params)
    @crawler_setting.user = current_user

    respond_to do |format|
      if @crawler_setting.save
        format.html { redirect_to crawler_setting_url(@crawler_setting), notice: "Crawler setting was successfully created." }
        format.json { render :show, status: :created, location: @crawler_setting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @crawler_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crawler_settings/1 or /crawler_settings/1.json
  def update
    respond_to do |format|
      if @crawler_setting.update(crawler_setting_params)
        format.html { redirect_to crawler_setting_url(@crawler_setting), notice: "Crawler setting was successfully updated." }
        format.json { render :show, status: :ok, location: @crawler_setting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @crawler_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crawler_settings/1 or /crawler_settings/1.json
  def destroy
    @crawler_setting.destroy

    respond_to do |format|
      format.html { redirect_to crawler_settings_url, notice: "Crawler setting was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def scrape
    CrawlerJob.perform_later @crawler_setting
    @crawler_setting.touch(:updated_at)
    redirect_to crawler_records_url, notice: 'The crawler job will be running in backend'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crawler_setting
      @crawler_setting = current_user.crawler_settings.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def crawler_setting_params
      params.require(:crawler_setting).permit(:name, :index_page_url, 
        :index_page_css, :detail_page_title_css, :category_id, :active,
        :detail_page_content_css, :detail_page_clean_up_css, :image_keyword)
    end
end
