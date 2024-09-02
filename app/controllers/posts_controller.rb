class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_user, only: [:new, :create, :edit, :update]
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

  def edit
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to user_post_path(@user, @post)
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @post.destroy!

    redirect_to @user
  end

  private

  def validate_user
    user = User.find(params[:user_id])
    redirect_to root unless user == current_user
  end

  def post_params
    params.require(:post).permit(:description, :recipe, :image)
  end
end
