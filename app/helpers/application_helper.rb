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

	def rand_cover
		%i[https://images.unsplash.com/photo-1712093828214-0b74bf899528?q=80&w=300 
		https://images.unsplash.com/photo-1532274402911-5a369e4c4bb5?q=80&w=300
		https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?q=80&w=300
		https://images.unsplash.com/photo-1413752362258-7af2a667b590?q=80&w=300
		https://images.unsplash.com/photo-1488590528505-98d2b5aba04b?q=80&w=300
		https://images.unsplash.com/photo-1531297484001-80022131f5a1?q=80&w=300
		https://images.unsplash.com/photo-1519389950473-47ba0277781c?q=80&w=300
		https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=300
		https://images.unsplash.com/photo-1478432780021-b8d273730d8c?q=80&w=300
		https://images.unsplash.com/photo-1581090700227-1e37b190418e?q=80&w=300
		https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=300
		https://images.unsplash.com/photo-1577473404054-cbdf6c62ebaa?q=80&w=300
		https://images.unsplash.com/photo-1544636331-e26879cd4d9b?q=80&w=300
		https://images.unsplash.com/photo-1582219227779-e3d6b58499b4?q=80&w=300
		https://images.unsplash.com/photo-1512078083908-46520ff2a87d?q=80&w=300
		https://images.unsplash.com/photo-1584028887908-f6d2257fe9d4?q=80&w=300
		].sample()
	end

end
