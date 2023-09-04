class HomeController < ApplicationController
  def index
    @posts = Post.recent
  end

  def users
    if not current_user.id.eql?(1)
      redirect_to root_path, msg: 'Can not access this page'
    end

    @users = User.order('created_at DESC').all
  end
end
