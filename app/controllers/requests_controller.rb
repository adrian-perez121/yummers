class RequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    Request.create!(request_params)
  end

  private

  def request_params
    params.require(:request).permit(:requested_id, :requester_id)
  end
  # Request.where(requester_id: 2, requested_id: 3).exists?
end
