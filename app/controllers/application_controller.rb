class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  include SessionsHelper
  before_action :check_logged_in

  def check_logged_in
    return if current_user

    redirect_to root_path
  end

  private

  def google_service_for(user)
    service = Google::Apis::CalendarV3::CalendarService.new
    credentials = Google::Auth::UserRefreshCredentials.new(
      client_id: Rails.application.credentials.google[:client_id],
      client_secret: Rails.application.credentials.google[:client_secret],
      scope: ['https://www.googleapis.com/auth/calendar'],
      refresh_token: user.google_refresh_token
    )
    service.authorization = credentials
    service
  end
end
