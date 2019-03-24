class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_message_user
	before_action :set_message_users
	# def new
	# 	@user=User.new
	# end

	# def create
	# 	@user=User.new(user_params)
	# 	if @user.save
	# 		redirect_to users_path
	# 	else
	# 		render 'new'
	# 	end
	# end


	def index
		if current_user.nil?
			redirect_to 'http://localhost:3000/auth/sign_in'
			return
		end

		@user=User.find(current_user.id)

		if (@user.user_type == "admin" )
			@users=User.where.not(:user_type => "admin")
		elsif (@user.user_type == "manager" )
			@users=(User.where(:org_id => @user.org_id)).where.not(:user_type => "manager")
		else
			@users=User.where(:org_id => @user.org_id)
		end
		render 'index'
	end

	def edit
		if(current_user.user_type=="admin")
			@user = User.find(params[:id])
		else
			flash[:error]= "You are not authorized"
			redirect_to users_path
		end
	end


	def update
		@user = User.find(params[:id])
		if @user.update (user_params)
			redirect_to user_path (@user)
		else
			render 'edit'
		end
	end
	def show
		@user=User.find(params[:id])
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy

		redirect_to users_path
	end

	def organizationusers
		@organization = Organization.where(:id => organization_params[:org_id]).first
		@users= User.where(:org_id => organization_params[:org_id] )

	end

	private


	def user_params
		params.require(:user).permit(:id,:name, :email, :password, :password_confirmation, :status, :user_type, :is_active)
	end

	def organization_params
		params.permit(:org_id)

	end

	def set_message_user

		if (current_user.user_type == "admin" )
			@userss=User.where.not(:user_type => "admin")
		elsif (current_user.user_type == "manager" )
			@userss=(User.where(:org_id => current_user.org_id).or(User.where(:user_type => "admin"))).where.not(:user_type => "manager")
		else
			@userss=User.where(:org_id => current_user.org_id).or(User.where(:user_type => "admin"))
		end
	end

end
