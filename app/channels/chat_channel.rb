class ChatChannel < ApplicationCable::Channel
  def subscribed # Your gonna have to switch to 'stream_for' later on since you have a chat model
    chat = Chat.find(params[:chat_id])
    stream_for chat
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def get_user_data
    chat = Chat.find(params[:chat_id])
    user = {
      id: current_user.id,
      name: current_user.name
    }
    ChatChannel.broadcast_to chat, { user: user }
  end
end
