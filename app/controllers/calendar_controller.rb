require 'google/apis/calendar_v3'

class CalendarController < ApplicationController
  def index
    servce = Google::Apis:CalendarV3::CalendarSeervice.new
    service.authorization = current.google_access_token

    calendar_id = 'primary'
    response = servie.list_events(calendar_id, mac_results: 10, single_events: true, order_by: 'startTime', time_min: Time.now.iso8601)

    @schedules = response.items.map do |schedule|
      {
        summary: schedule.summary,
        start: schedule.start.date || schedule.start.date_timem,
        end: schedule.end.date || schedule.end.date_time,
        location: evant.location
      }
  end
end
