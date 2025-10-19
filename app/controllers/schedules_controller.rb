
class SchedulesController < ApplicationController
  def index
    @schedules = current_user.schedules # あるいは全ユーザー

    respond_to do |format|
      format.html
      format.json do
        render json: @schedules.map { |schedule|
          {
            id: schedule.id,
            title: schedule.title,
            start: schedule.start_time,
            end: schedule.end_time
          }
        }
      end
    end
  end
end
