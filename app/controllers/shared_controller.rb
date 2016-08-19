# This Controller is for all shared pages for the app - landing pages, about, terms of use, etc.

class SharedController < ApplicationController

	def index
		redirect_to dashboard_users_path if current_user
	end


end
