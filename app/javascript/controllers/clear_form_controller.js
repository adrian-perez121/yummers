import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clear-form"
export default class extends Controller {
  static targets = ['field']
  connect() {
  }

  clear() {
    this.fieldTargets.forEach( (field) => {
      field.value = ''
    })
  }
}
