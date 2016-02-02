# This Controller is for all shared pages for the app - landing pages, about, terms of use, etc.

class SharedController < ApplicationController
	layout :resolve_layout #Before rendering check which layout we should show

	def index
		redirect_to dashboard_users_path if current_user
	end

	private

		# Determine layout based on action name
	  def resolve_layout
	    case action_name
	    when 'index'
	    	'blank'
	    else
	      'application'
	    end
	  end

end
