class HomeController < ApplicationController
  skip_before_action :authenticate_user, only: %i[ up ]

  def index
    default_limit = 6
    default_order = 'updated_at DESC'
    @crawlers = CrawlerSetting.order(default_order).limit(default_limit)
    @crawler_records = CrawlerRecord.order('created_at DESC').limit(default_limit)
    @posts = Post.order(default_order).limit(default_limit)
    @api_records = ApiCallRecord.order('created_at DESC').limit(default_limit)
  end

  def cat
    @category = Category.where(slug: params[:slug]).first
    @title = @category.name
    unless @category
      redirect_to root_path, notice: 'Can not find the category'
      return 
    end

    @cats = []
    @category.crawler_settings.each do |setting|
      pagy, posts = pagy(setting.posts.order('updated_at DESC'))
      @cats.push({name: setting.name, pagy: pagy, posts: posts})
    end #each

  end

  def favorites
    @pagy, @favorites = pagy current_user.favorite_posts.order('created_at DESC')
  end

  def users
    if not current_user.is_admin?()
      redirect_to root_path, msg: 'Can not access this page'
    end

    @users = User.order('created_at DESC').all
  end

  def up
    render json: {up: 'to date'}
  end

end
