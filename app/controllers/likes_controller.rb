class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = Like.new(like_params)
    @likeable = @like.likeable
    @likeable.like_counter += 1
    @likeable.save!
    @like.save!

    # You can't like and dislike something at the same time
    remove_dislike if @like.user.disliked?(@likeable)
  end

  def destroy
    @like = Like.find(params[:id])
    @likeable = @like.likeable
    @likeable.like_counter -= 1
    @likeable.save!
    @like.destroy!

  end

  private

  def remove_dislike
    Dislike.destroy_by(user: @like.user, dislikeable: @likeable)
    @likeable.dislike_counter -= 1
    @likeable.save!
  end
  def like_params
    params.require(:like).permit(:user_id, :likeable_type, :likeable_id)
  end
end
