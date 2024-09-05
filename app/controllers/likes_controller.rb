class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = Like.create(like_params)
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id, :comment_id)
  end
end
