class ApplicationController < ActionController::Base
	include Pagy::Backend

	before_action :authenticate_user!
	before_action :set_post_default_view
	helper_method :posts_path_with_view

	def set_post_default_view
		@post_view = Setting.get('default_view').blank? ? 'grid' : 'list'
	end

	def posts_path_with_view(*args)
		posts_path(view: @post_view)
	end

end
