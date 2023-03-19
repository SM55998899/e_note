class TodoController < ApplicationController
	def list
		@lists = List.where(user: current_user).order("created_at ASC")
	end
end
