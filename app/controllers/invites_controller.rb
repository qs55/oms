class InvitesController < ApplicationController
	before_action :authenticate_user!
#	before_action :set_organization
	before_action :set_user
	before_action :set_message_users

	def index
		@invites=current_user.invites
	end


	def new
		@invite=current_user.invites.new
		@organizations = Organization.all
	end

	def create

		if ((Organization.where(:user_id => current_user.id).present?) || current_user.user_type=="admin")


			if Invite.where(:email => invite_params[:email]).present?
				flash.now[:alert]= "User has already been invited"
				render('invites/new') and return
			end


			@invite = current_user.invites.new  
			@invite.user_id = current_user.id 
			@invite.organization_id = invite_params[:organization_id]
			@invite.email = invite_params[:email]
			@invite.name = invite_params[:name]

			@user=User.new
			@user.name = invite_params[:name]
			@user.email = invite_params[:email]
			@user.is_active = true
			@user.user_type= "employee"
			@user.manager_id= Organization.where(:id => invite_params[:organization_id]).first.user_id
			@user.org_id=invite_params[:organization_id]
			if @user.save

				if @invite.save
					flash[:success]= "Invite sent succesfully"
					redirect_to users_path
				else
					render 'new'
				end
			else
				flash.now[:alert]= "User could not be created"
				render 'new'
			end	 
		else
			flash.now[:alert]= "You have no organization to invite employee"
			render 'new'
		end
	end

	private
	def invite_params
		params.require(:invite).permit(:email,:name, :token, :organization_id)
	end

	def user_params
		param.require(:user_id)
	end

	def organization_params
		param.require(:organization).permit(:organization_id)
	end

	def set_organization
		@organization=current_user.organization
	end

	def set_user
		@user=User.find(current_user.id)
	end

end
