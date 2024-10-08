class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @searched_users = search_users
    render turbo_stream: turbo_stream.replace('user-search',
                                              partial: 'users/user_search',
                                              locals: { search_users: @searched_users})
  end

  def show
    @user = User.find(params[:id])
    retrieve_followers_and_requests
    @posts = @user.posts
    @likes = Like.where(likeable: @posts, user: current_user).group_by(&:likeable_id)
    @dislikes = Dislike.where(dislikeable: @posts, user: current_user).group_by(&:dislikeable_id)
    @searched_users = search_users
  end

  private

  def retrieve_followers_and_requests
    @sent_requests = Request.where(requester_id: @user.id).all.includes(:requested)
    @follow_requests = Request.where(requested_id: @user.id).all.includes(:requester)
    @followers = Following.where(followee_id: @user.id).all.includes(:follower)
    @following = Following.where(follower_id: @user.id).all.includes(:followee)
  end

  def search_users
    User.where(first_name: params[:user_first]).or(User.where(last_name: params[:user_last]))
  end
end
