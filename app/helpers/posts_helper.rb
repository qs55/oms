module PostsHelper

	def jiggle
		
		if (@user.user_type =='admin')
			@organizations=Organization.all
			render "userlist"
			render "organizationlist"
			
		elsif
			(@user.user_type =='manager' )
			render "userlist"
		else
			controller.redirect_to user_path(@user)
    	end
  	end

end
