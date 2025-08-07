import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="dropdown-toggle"
export default class extends Controller {
    static targets = ["dropdown", "all", "saved"]
    connect() {
        this.toggleDropdown();
    }
    toggleDropdown() {
        const selectedValue = this.dropdownTarget.value;
        if (selectedValue === "saved") {
            this.allTarget.classList.add("hidden");
            this.savedTarget.classList.remove("hidden");
        } else {
            this.allTarget.classList.remove("hidden");
            this.savedTarget.classList.add("hidden");
        }
    }
}