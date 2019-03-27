class CommentsController < ApplicationController
	 before_action :authenticate_user!
	before_action :set_post
	before_action :set_message_users

	def index
		@comments=@post.comments.all
	end

	def new
		@comment=@post.comments.new
	end

	def create
		@comment = @post.comments.new
		@comment.user_id=current_user.id
		@comment.post_id=params[:post_id]
		@comment.message=comment_params[:message]
		if @comment.save
			flash[:success]="Commented successfully"
			redirect_to post_path (@post)
		else
			flash.now[:error]="Comment failed"
			render 'new'
		end
	end

	def destroy
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		flash[:success]="Comment deleted successfully"
		redirect_to post_path(@post)
	end

	def show
	
	
	@comment = @post.comments.find(params[:id])
	end

	def edit
		@comment = @post.comments.find(params[:id])
	end

	def update

		@comment = @post.comments.find(params[:id])
		@comment.message=comment_params[:message]

		if @comment.update(comment_params)
			flash[:success]="Comment updated successfully"
			redirect_to post_path (@post)
		else
			render 'edit'
		end
	end


	private

	def comment_params
		params.require(:comment).permit(:message)
	end

	def post_params
		param.require(:post).permit(:post_id)
	end

	def set_post
		@post=Post.find(params[:post_id])
	end

end
