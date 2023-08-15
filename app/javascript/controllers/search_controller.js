import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["q"];
  
  perform() {
    console.log("I am searching", this.qTarget.value);
  }
}
