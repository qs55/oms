class PostsController < ApplicationController
	def index

	end

	def new
		@user = User.find(params[:user_id])
    	
	end

	def create
		@user = User.find(params[:user_id])
		@post = @user.posts.build(params[:post_params])
   		 if @post.save
   		 	redirect_to user_posts_path
   		 else
   		 	render 'new'
   		 end
	end

	def show

	end	

	def edit

	end

	def update

	end

	def destroy

	end

	private
	def post_params
		params.require(:post).permit(:title, :body, :status, :picture)
	end

end
