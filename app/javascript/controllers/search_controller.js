import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["q"];

  perform() {
    console.log("I am searching", this.qTarget.value);

    if (this.qTarget.value) {
      Turbo.visit(`/search?q=${this.qTarget.value}`, { frame: "nav--search--results" });
    }
  }
}
