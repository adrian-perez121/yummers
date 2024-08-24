class RequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    Request.create!(request_params)
    redirect_to user_path(params[:request][:requested_id])
  end

  private

  def request_params
    params.require(:request).permit(:requested_id, :requester_id)
  end
end
