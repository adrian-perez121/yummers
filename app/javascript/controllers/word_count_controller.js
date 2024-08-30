import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="word-count"
// Connects to data-controller="word-count"
export default class extends Controller {
  static targets = ["textField", "characterOutput"];
  static values= {
    maxLength: {type: Number, default: 0},
    minLength: {type: Number, default: 0}
  };

  connect() {
    this.lengthOutput()
  }
  lengthOutput() {
    const length = this.textFieldTarget.value.length;
    // Don't show anything when the length is larger than the min length and
    // and less than 70% of the max length

    if (this.minLengthValue <= length && length <= this.maxLengthValue * 0.95) {
      this.characterOutputTarget.classList.add("hidden")
    }
    else {
      this.characterOutputTarget.classList.remove("hidden")
      this.characterOutputTarget.innerHTML = `${length}/${this.maxLengthValue}`
      this.#tooClose(length)
    }

  }

  // A function for when you are getting too close to the min or the max
  #tooClose (length) {
    if (length < this.minLengthValue || length > (this.maxLengthValue * 0.98)) {
      this.characterOutputTarget.style.color = 'red'
    } else {
      this.characterOutputTarget.style.color = 'black'
    }
  }
}
