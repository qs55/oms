class ApplicationController < ActionController::Base
	respond_to :html, :json
	include Pundit
	protect_from_forgery
	respond_to :html, :json
	before_action :configure_permitted_parameters, if:  :devise_controller?
	before_action :authenticate_user!



	def after_sign_in_path_for(resource)
		if ( resource.user_type=='manager' && resource.org_id==nil)
			new_organization_path
		else
			root_path
		end
	end

	def set_message_users

		if (current_user.user_type == "admin" )
			@users=User.where.not(:user_type => "admin")
		elsif (current_user.user_type == "manager" )
			@users=(User.where(:org_id => current_user.org_id).or(User.where(:user_type => "admin"))).where.not(:user_type => "manager")
		else
			@users=User.where(:org_id => current_user.org_id).or(User.where(:user_type => "admin"))
		end
	end

	
	protected

	def configure_permitted_parameters

		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_type, :manager_id, :is_active])
		devise_parameter_sanitizer.permit(:account_update, keys: [:name, :user_type, :manager_id, :password, :password_confirmation, :current_password, :is_active])
	end

end
