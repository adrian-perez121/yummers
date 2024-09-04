class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_post_id, only: :create

  def create
    @post = Post.find(params[:comment][:post_id])
    @user = @post.author
    @comment = Comment.new(comment_params)
    @current_user = current_user
    @post_comments = @post.comments

    respond_to do |format|
      if @comment.save
        format.turbo_stream { render turbo_stream: turbo_stream.prepend('comments', @comment)}
      else
        format.html { render 'posts/show'}
      end
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
