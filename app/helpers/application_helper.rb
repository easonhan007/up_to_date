module ApplicationHelper
	include Pagy::Frontend

	def back_link
		link_to('Back', 'javascript:history.back()', class: 'btn btn-secondary')
	end
end
