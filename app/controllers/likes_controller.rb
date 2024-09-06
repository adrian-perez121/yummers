class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = Like.new(like_params)
    @like.save!

    render turbo_stream: turbo_stream.replace('like-form',
                                              partial: 'likes/unlike_button',
                                              locals: { like: @like, likeable: @like.likeable})
  end

  def destroy
    @like = Like.find(params[:id])
    @likeable = @like.likeable
    @like.destroy!

    render turbo_stream: turbo_stream.replace('like-form',
                                              partial: 'likes/like_button',
                                              locals: { likeable: @likeable})
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :likeable_type, :likeable_id)
  end
end
