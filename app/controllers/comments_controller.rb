class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_post_id, only: :create

  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to user_post_path(@post.author, @post)
    else
      flash[:alert] = 'Comment was unable to process'
      redirect_to user_post_path(@post.author, @post), status: :unprocessable_content
    end
  end

  private

  def check_post_id
    flash[:notice] = 'A post must be specified when making a comment'
    redirect_to root_path unless params[:comment][:post_id]
  end

  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :comment_id, :body)
  end
end
