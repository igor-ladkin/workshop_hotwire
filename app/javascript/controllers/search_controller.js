import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["q", "results"];

  perform() {
    if (this.qTarget.value) {
      Turbo.visit(`/search?q=${this.qTarget.value}`, { frame: "nav--search--results" });
    }
  }

  hide(e) {
    this.resultsTarget.innerHTML = "";
  }
}
