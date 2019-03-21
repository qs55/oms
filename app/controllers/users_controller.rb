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
		if current_user.nil?
     		 redirect_to 'http://localhost:3000/auth/sign_in'
     		 return
    	end

		@user=User.find(current_user.id)

		if (@user.user_type == "manager")  
			@users=@user.subordinates.where.not(:user_type => 'admin')
		elsif (@user.user_type == "admin" )
			@users=User.all.where.not(:user_type => 'admin')
		else
			@users=User.where(:org_id => @user.org_id).or(User.where(:user_type => "admin"))
		end
		render 'index'
		

		
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
		@invites= Organization.find(organization_params[:org_id]).invites
	end

	def root
		redirect_to new_user_session_path
	end


	private


def user_params
	params.require(:user).permit(:id)
end

def organization_params
	params.permit(:org_id)
end
end
