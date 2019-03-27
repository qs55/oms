class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user
	before_action :set_message_users

	def index
		if current_user.admin?
			@posts= Post.all.where(:status => "active")
		else 
			@ids = User.select("id").where(:org_id => current_user.org_id).or(User.select("id").where(:user_type => "admin"))
			@posts=Post.where(:user_id => @ids).where(:status => "active")
		end
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
		flash[:success]="Post deleted successfully"
		redirect_to posts_path

	end

	def allposts
		@posts=Organization.all
	end

	def archived
		@posts= current_user.posts.where(:status => "archived")
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
