import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="search"
export default class extends Controller {
    static targets = ["optionA", "optionB", "optionC", "optionD", "searchInput"]
  connect() {
    console.log("Search controller connected");
    this.updateVisibility();
  }

  updateVisibility() {
    const selectedOption = this.searchInputTarget.value;
    this.optionATarget.classList.toggle("hidden", selectedOption !== "title");
    this.optionATarget.disabled = selectedOption !== "title";
    this.optionBTarget.classList.toggle("hidden", selectedOption !== "authors");
    this.optionBTarget.disabled = selectedOption !== "authors";
    this.optionCTarget.classList.toggle("hidden", selectedOption !== "isbn");
    this.optionCTarget.disabled = selectedOption !== "isbn";
    this.optionDTarget.classList.toggle("hidden", selectedOption !== "course_number");
    this.optionDTarget.disabled = selectedOption !== "course_number";
    console.log(`Selected option: ${selectedOption}`);
    
  }
}