class InvitesController < ApplicationController
	before_action :set_organization



	def new
		@invite=current_user.invites.new
	end

	def create
	  	@invite = current_user.invites.new  # Make a new Invite
	    @invite.user_id = current_user.id # set the sender to the current user
	    @invite.organization_id = @organization.id
	    @invite.email = invite_params[:email]
	    if @invite.save
#S	       InviteMailer.new_user_invite(@invite, new_user_registration_path(:invite_token => @invite.token)).deliver #send the invite data to our mailer to deliver the email
			UserMailer.set_password(@invite, @organization).deliver
			redirect_to invites_path
	    else
	      	render 'new'
	    end
	end

	private
	def invite_params
		params.require(:invite).permit(:email, :token)
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


end
