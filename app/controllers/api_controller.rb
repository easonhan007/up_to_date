class ApiController < ActionController::API
  before_action :verify_api_key

  def scrape_all
    settings = CrawlerSetting.activated.order('updated_at ASC').all
    settings.each do |setting|
      CrawlerJob.perform_later setting
      setting.touch(:updated_at)
    end
    render json: { status: 'SUCCESS', message: 'Crawler Job created', data: settings.pluck(:name)}, status: :created    
  end

  private
    def verify_api_key
      predefine_key = ENV["API_KEY"] || "uENDNmLWOk"
      key = params[:api_key]
      if key
        if key.strip().eql?(predefine_key)
          return true
        end #if
      end #if
      render json: {message: "FORBIDDEN"}, status: :forbidden
    end

end

