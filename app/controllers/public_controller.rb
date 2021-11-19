class PublicController < ApplicationController

	def homepage
		@posts = Post.all.active.order_by_latest_first.limit_2 { |e| }
		@categories = Category.all
	end
end
