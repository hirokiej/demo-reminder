import { Controller } from "@hotwired/stimulus";
import { Calendar } from "@fullcalendar/core";
import dayGridPlugin from "@fullcalendar/daygrid";

export default class extends Controller {
  connect() {
    this.calendar = new Calendar(this.element, {
      plugins: [dayGridPlugin],
      initialView: "dayGridMonth",
      events: "/schedules.json",
    });
    this.calendar.render();
  }
  disconnect() {
    this.calendar.destroy();
  }
}
