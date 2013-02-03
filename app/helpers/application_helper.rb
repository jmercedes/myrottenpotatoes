module ApplicationHelper

	def sortable(column, title=nil)
		title ||= column.titleize

		if column == "title"
			current = "movie_title_header"
		elsif column == "release_date"
			current = "release_date_header"
		else
			current = nil
		end


		 	 
		@css_class = current
		direction = column == sort_column && sort_direction == "asc" ? "desc" : "desc"
		haml_tag :th, :class => "#{"hilite" if column == sort_column}" do 
		haml_concat link_to title, {:sort => column, :direction => direction}, {:id => @css_class}
		end
	end


end
