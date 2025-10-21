require 'line/bot'

class LinewebhookController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :check_logged_in, only: [:callback]

  def callback
    body = request.body.read
    signature = request.headers['X-Line-Signature']

    line_account = find_line_account_by_signature(body, signature)

    client = Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: line_account.line_channel_access_token)
    events = JSON.parse(body)['events']

    events.each do |event|
      user_id = event.dig('source', 'userId')
      next unless user_id
      
      handle_follow(user_id, line_account, client)
    end

    head :ok
  end

  private

  def find_line_account_by_signature(body,signature)
    User.find_each do |account|
      next unless account.line_channel_secret.present?

      if valid_signature?(body,signature, account.line_channel_secret)
        return account
      end
    end
    nil
  end

  def valid_signature?(body,signature, channel_secret)
    hash = OpenSSL::HMAC.digest(OpenSSL::Digest::SHA256.new, channel_secret, body)
    Base64.strict_encode64(hash) == signature
  end

  def handle_follow(user_id, line_account, client)
    return if line_account.friends.exists?(line_user_id: user_id)

    profile = client.get_profile(user_id: user_id)
    display_name = profile.display_name

    line_account.friends.create(line_user_id: user_id, line_display_name: display_name)
  end
end
