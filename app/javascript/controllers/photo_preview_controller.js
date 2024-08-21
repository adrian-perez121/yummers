import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="photo-preview"
export default class extends Controller {
  static targets = ["imageField", "imagePreview"]
  static values = { h: {type: Number, default: 50 },  w: { type:Number, default: 50}}

  connect () {
    this.preview()
  }

  preview() {
    let input = this.imageFieldTarget
    let preview = this.imagePreviewTarget
    let file = input.files[0]
    let reader = new FileReader()
    // This event happens when the reading is finished.
    reader.onloadend = function () {
      preview.src = reader.result
    }

    if (file) {
      reader.readAsDataURL(file)
    } else {
      preview.src = "" // There was no file but this shouldn't happen
    }
  }
}
