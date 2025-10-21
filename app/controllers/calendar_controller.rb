require 'google/apis/calendar_v3'

class CalendarController < ApplicationController
  def index
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = current_user.google_access_token

    calendar_id = 'primary'
    response = service.list_events(calendar_id, max_results: 10, single_events: true, order_by: 'startTime', time_min: Time.now.iso8601)

    @schedules = response.items.map do |schedule|
      {
        summary: schedule.summary,
        start: schedule.start.date || schedule.start.date_time,
        end: schedule.end.date || schedule.end.date_time,
        location: event.location
      }
  end
end
