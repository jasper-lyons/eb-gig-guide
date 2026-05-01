import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

export default class extends Controller {
  static targets = ["select"]
  static values = { searchUrl: String }

  connect() {
    this.tomSelect = new TomSelect(this.selectTarget, {
      maxItems: 1,
      valueField: "id",
      labelField: "name",
      searchField: "name",
      shouldLoad: (query) => query.length >= 1,
      load: (query, callback) => {
        fetch(`${this.searchUrlValue}?q=${encodeURIComponent(query)}`)
          .then(r => r.json())
          .then(callback)
          .catch(() => callback())
      },
      create: (input) => ({ id: `new:${input}`, name: input }),
      render: {
        option_create: (data, escape) =>
          `<div class="create">Add <strong>${escape(data.input)}</strong>&hellip;</div>`,
      },
    })
  }

  disconnect() {
    this.tomSelect?.destroy()
  }
}
