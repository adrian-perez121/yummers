class FollowingsController < ApplicationController
  before_action :validate_request_existence, only: :create

  def create
    Following.create!(follow_params)
    @request = Request.find_by(request_params)
    @request.destroy! # When a following is created the corresponding request needs to be deleted
    @user = User.find(params[:following][:followee_id])

    redirect_to @user
  end

  private

  def follow_params
    params.require(:following).permit(:follower_id, :followee_id)
  end

  def request_params
    params.require(:request).permit(:id)
  end

  def validate_request_existence
    unless Request.where(requested_id: params[:following][:followee_id], requester_id: params[:following][:follower_id]).exists?
      flash.now[:notice] = 'The user needs to request you before they can follow you.'
      @user = User.find(params[:following][:followee_id])
      render @user, status: :forbidden
    end
  end
end
