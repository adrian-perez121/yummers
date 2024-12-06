import { Controller } from "@hotwired/stimulus";
import  consumer  from "channels/consumer";

// Connects to data-controller="chat"
export default class extends Controller {
  connect() {
    let chatId = this.element.dataset.chatId
    this.sub = this.createActionCableChannel(chatId);
    const other = this.application.getControllerForElementAndIdentifier(this.element, 'scroll')
    this.sub.controller = other
  }

  disconnect() {
    console.log("The controller is being disconnected")
  }

  createActionCableChannel (chatId) {
    return consumer.subscriptions.create({channel: "ChatChannel", chat_id: chatId }, {
      connected() {
        // Called when the subscription is ready for use on the server
        // This was a test to see how the channel worked
        this.perform("get_user_data", { chat_id: chatId })
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        // Called when there's incoming data on the websocket for this channel
        if (data.user) { // this should happen pretty much once when the user connects
          this.current_user = data.user
        }

        if (data.message) {
          this.append_message(data.message)
          this.controller.scrollToBottom()
        }
      },

      // Function to add a message when it is sent in action cable
      append_message(message) {
        let chat_box = document.querySelector(`[data-chat-id="${message.chat_id}"]`)
        let message_bubble = document.createElement("div")
        message_bubble.classList.add("message")
        message_bubble.textContent = message.message
        if (message.sender_id == this.current_user.id) {
          message_bubble.classList.add("right")
        } else {
          message_bubble.classList.add("left")
        }
        chat_box.appendChild(message_bubble)
      }
    });
  }
}
