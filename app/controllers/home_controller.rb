class HomeController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index]

  def index
    @categories = Category.order('created_at DESC')
  end

  def cat
    @category = Category.where(slug: params[:slug]).first
    unless @category
      redirect_to root_path, notice: 'Can not find the category'
    end
  end

  def users
    if not current_user.id.eql?(1)
      redirect_to root_path, msg: 'Can not access this page'
    end

    @users = User.order('created_at DESC').all
  end
end
