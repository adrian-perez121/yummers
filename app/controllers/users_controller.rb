class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @sent_requests = Request.where(requester_id: @user.id).all.includes(:requested)
    @follow_requests = Request.where(requested_id: @user.id).all.includes(:requester)
    @searched_users = search_users
  end

  private

  def search_users
    User.where(first_name: params[:user_first]).or(User.where(last_name: params[:user_last]))
  end
end
