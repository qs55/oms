class UserMailer < ApplicationMailer

	def set_password (invite, organization, user)
		@invite=invite
		@organization=organization
		@user = user
		mail(to: @invite.email, subject: "You have this invited to join #{@organization.name}")
	end
end
