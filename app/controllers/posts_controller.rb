class PostsController < ApplicationController
	before_action :set_user

	def index
		@posts=current_user.posts.all
	end

	def new
    	@post=current_user.posts.new
	end

	def create
		@post = current_user.posts.create(post_params)
   		 if @post.save
   		 	redirect_to post_path(@post)
   		 else
   		 	render 'new'
   		 end
   		
	end

	def show
		@post = Post.find(params[:id])
	end	

	def edit
		@post= Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
			
			if @post.update(post_params)
				redirect_to post_path(@post)
			else
				render 'edit'
			end
	end

	def destroy
		 @post = Post.find(params[:id])
   		 @post.destroy
    	 redirect_to request.referrer

	end

	private
	def post_params
		params.require(:post).permit(:title, :body, :status, :avatar)
	end

	def user_params
		param.require(:user_id)
	end
	def set_user
		@user = User.find(current_user.id)
	end

end
