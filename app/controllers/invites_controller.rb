class InvitesController < ApplicationController
	before_action :set_organization
	before_action :set_user




	def new
		@invite=current_user.invites.new
	end

	def create
#		@user = User.new
#		@user.name = invite_params[:name]
#		@user.email=invite_params[:email]
		if (Organization.where(:user_id => current_user.id).present?)
		
		
		if Invite.where(:email => invite_params[:email]).present?
			flash.now[:alert]= "User has already been invited"
			render('invites/new') and return
		end


	  	@invite = current_user.invites.new  # Make a new Invite
	    @invite.user_id = current_user.id # set the sender to the current user
	    @invite.organization_id = @organization.id
	    @invite.email = invite_params[:email]
	    @invite.name = invite_params[:name]

	    @user=User.new
	    @user.name = invite_params[:name]
	    @user.email = invite_params[:email]
	    @user.user_type= "employee"
	    @user.manager_id=current_user.id
	    @user.org_id=@organization.id

	    if @user.save

	    	if @invite.save
#	       		InviteMailer.new_user_invite(@invite, new_user_registration_path(:invite_token => @invite.token)).deliver #send the invite data to our mailer to deliver the email
#				UserMailer.set_password(@invite, @organization, @user).deliver
				redirect_to invites_path
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
		params.require(:invite).permit(:email,:name, :token)
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
