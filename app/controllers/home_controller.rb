class HomeController < ApplicationController

  def index
    @categories = Category.order('weight DESC').order('created_at DESC')
    @custom_layout = "col-md-12"
  end

  def cat
    @category = Category.where(slug: params[:slug]).first
    @custom_layout = "col-md-12"
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
