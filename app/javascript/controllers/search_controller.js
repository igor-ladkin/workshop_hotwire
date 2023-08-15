import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["q", "results"];

  perform() {
    if (this.qTarget.value) {
      Turbo.visit(`/search?q=${this.qTarget.value}`, { frame: "nav--search--results" });
    }
  }

  select(e) {
    e.preventDefault();

    this.qTarget.value = "";
    this.resultsTarget.innerHTML = "";

    const frame = e.target.dataset.turboFrame;
    const path = e.target.href;

    if (frame) {
      Turbo.visit(path, { frame });
    } else {
      Turbo.visit(path);
    }
  }
}
