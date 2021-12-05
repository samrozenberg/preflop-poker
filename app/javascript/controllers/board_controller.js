import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["flop"]

  connect() {
    console.log("Hello");
  }

  flop() {
    this.flopTarget.classList.remove('d-none')
  }
}
