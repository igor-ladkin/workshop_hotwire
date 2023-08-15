import { Controller } from "@hotwired/stimulus";
import { useDebounce, useClickOutside } from "stimulus-use";

export default class extends Controller {
  static targets = ["q", "results"];
  static debounces = ["perform"]

  connect() {
    useClickOutside(this);
    useDebounce(this, { wait: 300 });
  }

  clickOutside(e) {
    this.clear();
  }


  perform() {
    if (this.qTarget.value) {
      Turbo.visit(`/search?q=${this.qTarget.value}`, { frame: "nav--search--results" });
    }
  }

  select(e) {
    e.preventDefault();

    const frame = e.target.dataset.turboFrame;
    const path = e.target.href;

    this.clear();

    if (frame) {
      Turbo.visit(path, { frame });
    } else {
      Turbo.visit(path);
    }
  }

  clear() {
    this.qTarget.value = "";
    this.resultsTarget.innerHTML = "";
  }
}
