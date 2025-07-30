import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="search"
export default class extends Controller {
    static targets = ["optionA", "optionB", "optionC", "optionD", "input"]
  connect() {
    console.log("Search controller connected");
    this.updateVisibility();
  }

  updateVisibility() {
    const selectedOption = this.inputTarget.value;
    this.optionATarget.classList.toggle("hidden", selectedOption !== "title");
    this.optionBTarget.classList.toggle("hidden", selectedOption !== "authors");
    this.optionCTarget.classList.toggle("hidden", selectedOption !== "isbn");
    this.optionDTarget.classList.toggle("hidden", selectedOption !== "course_number");
  }
}