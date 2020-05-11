class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	#protect_from_forgery with: :null_session
	skip_before_action :verify_authenticity_token
	before_action :authenticate_user!

	def after_sign_in_path_for(resource_or_scope)
	  unless current_user.nil?
	  	if can? :read, User
	  		rails_admin.dashboard_path
	  	else
	  		customers_path
	  	end
	  else
		home_index_path
	  end
	end

	def set_access_control_headers
	  headers['Access-Control-Allow-Origin'] = '*'
	end
end
