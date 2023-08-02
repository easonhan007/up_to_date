require 'open-uri'
class CrawlerSettingsController < ApplicationController
  before_action :set_crawler_setting, only: %i[ show edit update destroy, scrape ]

  # GET /crawler_settings or /crawler_settings.json
  def index
    @crawler_settings = current_user.crawler_settings.all
  end

  # GET /crawler_settings/1 or /crawler_settings/1.json
  def show
  end

  # GET /crawler_settings/new
  def new
    @crawler_setting = CrawlerSetting.new
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
    @crawler_setting.scrape()
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crawler_setting
      @crawler_setting = current_user.crawler_settings.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def crawler_setting_params
      params.require(:crawler_setting).permit(:name, :index_page_url, 
        :index_page_css, :detail_page_title_css, 
        :detail_page_content_css, :detail_page_clean_up_css)
    end
end
