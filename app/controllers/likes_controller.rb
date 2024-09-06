class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = Like.new(like_params)
    @likeable = @like.likeable
    @likeable.like_counter += 1
    @likeable.save!
    @like.save!

    render turbo_stream: turbo_stream.replace(like_target(@likeable),
                                              partial: 'likes/unlike_button',
                                              locals: { like: @like, likeable: @like.likeable})
  end

  def destroy
    @like = Like.find(params[:id])
    @likeable = @like.likeable
    @likeable.like_counter -= 1
    @likeable.save!
    @like.destroy!

    render turbo_stream: turbo_stream.replace(like_target(@likeable),
                                              partial: 'likes/like_button',
                                              locals: { likeable: @likeable})
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :likeable_type, :likeable_id)
  end

  def like_target(likeable)
    "like-form-#{likeable.class.name}-#{likeable.id}"
  end
end
