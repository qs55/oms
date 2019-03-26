class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user
	before_action :set_message_users

	def index
		@posts=current_user.posts.all.where(:status => "active")
	end

	def new
		@post=current_user.posts.new
		if(current_user.user_type=="admin")
			@users=User.where.not(:user_type => "admin")
		else
			@users =User.where(:org_id => current_user.org_id)
		end
	end

	def create
		@post = current_user.posts.create(post_params)
		if @post.save
			redirect_to post_path(@post)
		else
			flash.now[:error]= "Post creation failed. All fields are necessary."
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

	def allposts
		@posts=Organization.all
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
