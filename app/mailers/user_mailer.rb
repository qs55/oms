class UserMailer < ApplicationMailer

	def set_password (invite, organization)
		@invite=invite
		@organization=organization
		mail(to: @invite.email, subject: "You have this invited to join #{@organization.name}")
	end
end
