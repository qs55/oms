module UsersHelper

	def jiggle
		if (@user.user_type =='admin')
			
			render "adminview"
			
		elsif
			(@user.user_type =='manager' )
			render "managerview"
		else
			render "userview"
    	end
  	end
end
