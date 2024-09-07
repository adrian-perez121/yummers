class DislikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @dislike = Dislike.new(dislike_params)
    @dislikeable = @dislike.dislikeable
    @dislikeable.dislike_counter += 1
    @dislikeable.save!
    @dislike.save!

    remove_like  if @dislike.user.liked?(@dislikeable)
  end

  def destroy
    @dislike = Dislike.find(params[:id])
    @dislikeable = @dislike.dislikeable
    @dislikeable.dislike_counter -= 1
    @dislikeable.save!
    @dislike.destroy!
  end

  private

  def remove_like
    Like.destroy_by(user: @dislike.user, likeable: @dislikeable)
    @dislikeable.like_counter -= 1
    @dislikeable.save!
  end

  def dislike_params
    params.require(:dislike).permit(:user_id, :dislikeable_type, :dislikeable_id)
  end
end
