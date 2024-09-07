class DislikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @dislike = Dislike.new(dislike_params)
    @dislikeable = @dislike.dislikeable
    @dislikeable.dislike_counter += 1
    @dislikeable.save!
    @dislike.save!

    render turbo_stream: turbo_stream.replace(dislike_target(@dislikeable),
                                              partial: 'dislikes/undislike_button',
                                              locals: { dislike: @dislike, dislikeable: @dislikeable})
  end

  def destroy
    @dislike = Dislike.find(params[:id])
    @dislikeable = @dislike.dislikeable
    @dislikeable.dislike_counter -= 1
    @dislikeable.save!
    @dislike.destroy!

    render turbo_stream: turbo_stream.replace(dislike_target(@dislikeable),
                                              partial: 'dislikes/dislike_button',
                                              locals: { dislikeable: @dislikeable})
  end

  private

  def dislike_params
    params.require(:dislike).permit(:user_id, :dislikeable_type, :dislikeable_id)
  end

  def dislike_target(dislikeable)
    "dislike-form-#{dislikeable.class.name}-#{dislikeable.id}"
  end
end
