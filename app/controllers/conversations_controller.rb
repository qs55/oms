class ConversationsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_message_users

	def index
		@user=User.find(current_user.id)
		if (@user.user_type == "manager")  
			@users=@user.subordinates.where.not(:user_type => 'admin')
		elsif (@user.user_type == "admin" )
			@users=User.all.where.not(:user_type => 'admin')
		else
			@users=User.where(:org_id => @user.org_id).or(User.where(:user_type => "admin"))
		end
		@conversations = Conversation.all
	end

	def create
		if Conversation.between(params[:sender_id],params[:recipient_id]).present?
			@conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
		else
			@conversation = Conversation.create!(conversation_params)
		end

		redirect_to conversation_messages_path(@conversation)

	end

	private

	def conversation_params
		params.permit(:sender_id, :recipient_id)
	end

end
