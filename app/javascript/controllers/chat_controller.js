import { Controller } from "@hotwired/stimulus";
import  consumer  from "channels/consumer";

// Connects to data-controller="chat"
export default class extends Controller {
  connect() {
    let chatId = this.element.dataset.chatId
    console.log(chatId)
    this.sub = this.createActionCableChannel(chatId);
    // console.log(this.sub)
  }

  disconnect() {
    console.log("The controller is being disconnected")
  }

  createActionCableChannel (chatId) {
    return consumer.subscriptions.create({channel: "ChatChannel", chat_id: chatId }, {
      connected() {
        // Called when the subscription is ready for use on the server
        this.perform("get_user_data", { chat_id: chatId })
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log(data.user.name)
      }
    });
  }
}
