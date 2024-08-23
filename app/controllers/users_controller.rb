class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @sent_requests = @user.requests
    @follow_requests = @user.requesters
  end
end
