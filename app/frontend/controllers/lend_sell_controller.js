import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="lend-sell"
export default class extends Controller {
  static targets = ["input", "priceInput"]
  connect() {
    this.determinePriceVisibility();
  }

  determinePriceVisibility() {
    const selectedValue = this.inputTarget.value;
    if (selectedValue === "sell") {
      this.priceInputTarget.classList.remove("hidden");
    } else {
      this.priceInputTarget.classList.add("hidden");
    }
  }
}
