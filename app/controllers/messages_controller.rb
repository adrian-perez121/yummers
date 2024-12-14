class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @chat = @message.chat

    @message.save! # I want this to break if the message doesn't save
    # redirect_to @message.chat # Temporary, this should have websockets instead
  end

  private

  def message_params
    params.require(:message).permit(:chat_id, :message, :sender_id)
  end
end
