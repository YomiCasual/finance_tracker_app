module ApplicationHelper

	def active_nav_bar(path)
		'active-nav-bar' if request.path === path
	end
end
