import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="clear-files"
export default class extends Controller {
    static targets = ["fileInput", "imageLabel"]
    connect() {
        this.updateImageLabel();
    }
    updateImageLabel() {
        if (this.fileInputTarget.files.length > 0) {
            const numFiles = this.fileInputTarget.files.length;
            const fileNames = Array.from(this.fileInputTarget.files).map(file => file.name).join(", ");
            this.imageLabelTarget.textContent = `Selected files: ${numFiles} (${fileNames})`;
        } else {
            this.imageLabelTarget.textContent = "Add photos";
        }
    }

}