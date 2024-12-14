import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  connect() {

    const messages = document.getElementById("messages")
    // here we don't care about what is getting passed into the callback
    const observer = new MutationObserver(() => {
      this.scrollToBottom() // This is all we really want to happen
    })
    observer.observe(messages, { childList: true }) // look at messages' children
    this.scrollToBottom()
  }

  scrollToBottom() {
    this.element.scrollTop = this.element.scrollHeight
  }
}
