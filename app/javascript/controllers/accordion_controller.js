import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="accordion"
export default class extends Controller {
  static targets = ["content", "arrowDown", "arrowUp"];

  toggle() {
    const content = this.contentTarget;
    const arrowDown = this.arrowDownTarget;
    const arrowUp = this.arrowUpTarget;

    if (content.style.height === "0px" || content.style.height === "") {
      content.style.height = "auto";
      arrowDown.style.display = "none";
      arrowUp.style.display = "block";
    } else {
      content.style.height = "0px";
      arrowDown.style.display = "block";
      arrowUp.style.display = "none";
    }
  }
}