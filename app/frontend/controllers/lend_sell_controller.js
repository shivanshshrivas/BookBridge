import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="lend-sell"
export default class extends Controller {
  static targets = ["input", "priceInput"]
  connect() {
    this.determinePriceVisibility();
  }

  determinePriceVisibility() {
    const selectedValue = this.inputTarget.value;
    if (selectedValue === "Sell") {
      this.priceInputTarget.querySelector("input").disabled = false; 
      this.priceInputTarget.classList.remove("invisible");
    } else {
      this.priceInputTarget.querySelector("input").disabled = true;
      this.priceInputTarget.classList.add("invisible");
    }
  }
}
