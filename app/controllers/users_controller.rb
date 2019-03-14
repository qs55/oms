class UsersController < ApplicationController

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
		@users=User.order("name")
	end

	def show
		@user=User.find(params[:id])
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy

		redirect_to users_path
	end

end