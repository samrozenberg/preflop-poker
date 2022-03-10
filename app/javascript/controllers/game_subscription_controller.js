import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { gameId: Number }
  static targets = ["messages", "form"]

  connect() {
    this.channel = consumer.subscriptions.create(
      { channel: "GameChannel", id: this.gameIdValue },
      { received: data => console.log(data) }
    )
    console.log(`Subscribed to the game with the id ${this.gameIdValue}.`)
  }
}
