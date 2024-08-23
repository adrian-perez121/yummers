class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @sent_requests = @user.requests
    @follow_requests = @user.requesters
    @searched_users = User.where(first_name: params[:user_first]).or(User.where(last_name: params[:user_last]))
  end
end
