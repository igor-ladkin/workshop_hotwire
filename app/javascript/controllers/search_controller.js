import { Controller } from "@hotwired/stimulus";
import { useDebounce } from "stimulus-use";

export default class extends Controller {
  static targets = ["q", "results"];
  static debounces = ["perform"]

  connect() {
    useDebounce(this, { wait: 300 });
  }


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
