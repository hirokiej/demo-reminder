
class SchedulesController < ApplicationController
  def index
    @schedules = current_user.schedules.all # あるいは全ユーザー

    service = Google::Apis::CalendarV3::CalendarService.new
    service = google_service_for(current_user)

    calendar_id = 'primary'
    response = service.list_events(calendar_id, max_results: 10, single_events: true, order_by: 'startTime', time_min: Time.now.iso8601)

    @schedules = response.items.map do |schedule|
      {
        summary: schedule.summary,
        start: schedule.start.date || schedule.start.date_time,
        end: schedule.end.date || schedule.end.date_time,
        location: schedule.location
      }
    end
  end
end
