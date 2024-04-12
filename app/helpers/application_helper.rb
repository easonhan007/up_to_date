module ApplicationHelper
	include Pagy::Frontend

	def back_link
		link_to('Back', 'javascript:history.back()', class: 'btn btn-secondary')
	end

	def active_kls(path)
		path.eql?(request.path) ? 'active' : ''
	end

	def nav_kls(path)
		"nav-link #{active_kls(path)}"
	end

end
