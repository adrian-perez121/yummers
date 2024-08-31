import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hidden"
export default class extends Controller {
  // This hidden controller chooses the element to hide based on id
  static targets = ["input", "field"]
  connect() {
  }

  toggle(event) {
    let keepOnId = event.target.value
    this.#highlightSelected(event)
    this.fieldTargets.forEach((field) => {
      let fieldId = field.id
      if (fieldId === keepOnId) {
        field.classList.remove('hidden')
      } else {
        field.classList.add('hidden')
      }
    })
  }

  #highlightSelected(event) {
    this.inputTargets.forEach((input) => {
      if (event.target == input) {
        input.classList.add('selected')
      } else {
        input.classList.remove('selected')
      }
    })
  }
}
