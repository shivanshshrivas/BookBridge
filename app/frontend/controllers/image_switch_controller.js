import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-switch"
export default class extends Controller {
  static targets = ["mainImage", "thumbnail"]

  connect() {
    this.setActiveThumbnail(this.thumbnailTargets[0]) // Set initial border
  }

  updateImage(event) {
    const clickedThumb = event.currentTarget
    const newImageUrl = clickedThumb.dataset.imageUrl

    // Update the main image
    this.mainImageTarget.src = newImageUrl

    // Update active thumbnail border
    this.setActiveThumbnail(clickedThumb)
  }

  setActiveThumbnail(activeThumb) {
    this.thumbnailTargets.forEach(thumb => {
      thumb.classList.remove("border-blue-500")
      thumb.classList.add("border-none")
    })
    activeThumb.classList.add("border-blue-500")
    activeThumb.classList.remove("border-none")
  }
}
