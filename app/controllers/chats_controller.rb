class ChatsController < ApplicationController
  def index
    @user = current_user
    @chats = Chat.where(chatter_1_id: @user.id ).or(Chat.where(chatter_2_id: @user.id))
  end

  def show
    @chat = Chat.find(params[:id])
  end
end
