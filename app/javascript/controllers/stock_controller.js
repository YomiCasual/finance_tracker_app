import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="stock"
export default class extends Controller {
  connect() {
    this.element.textContent = "hello world";
  }

  initialize() {
    this.element.setAttribute("data-action", "click->stock#showStock");
  }

  showStock() {
    alert("I am an alert box!");
  }
}
