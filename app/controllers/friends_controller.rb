class FriendsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def show
    @friends = current_user.friends.find(params[:id])
  end

  def edit
    @friend = current_user.friends.find(params[:id])
  end

  def update
    @friend = current_user.friends.find(params[:id])
    if @friend.update(friend_params)
      redirect_to friends_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def schedules
    @friend = current_user.friends.find(params[:friend_id])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = current_user.google_token

    calendar_id = 'primary'
    response = service.list_events(calendar_id, max_results: 10, single_events: true, order_by: 'startTime', time_min: Time.now.iso8601)
    
    @schedules = response.items.select do |schedule|
      schedule.summary.include?(@friend.real_name)
    end
  end

  private

  def friend_params
    params.require(:friend).permit(:real_name)
  end
end
