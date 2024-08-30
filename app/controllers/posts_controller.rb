class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.all
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)


    if @post.save
      redirect_to @user
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def post_params
    params.require(:post).permit(:description, :recipe, :image)
  end
end
