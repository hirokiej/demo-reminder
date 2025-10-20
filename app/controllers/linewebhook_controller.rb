class LinewebhookController < ApplicationController
  def callback
    body = request.body.read
    events = client.parse_event_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Follow
        handle_follow(event)
      when Line::Bot::Event::Message
        handle_message(event)
      end
    end

    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = current_user.line_channel_secret
      config.channel_token = current_user.line_channel_access_token
    end
  end

  def handle_follow(event)
    user_id = event.source.user_id
    return if current_user.friends.exists?(line_user_id: user_id)
    profile = JSON.parse(client.get_profile(user_id).body)
    display_name = profile['displayName']
    current_user.friends.create(line_user_id: user_id, line_display_name: display_name)
  end

  def handle_message(event)
    user_id = event.source.user_id

    unless current_user.friends.exists?(line_user_id: user_id)
      handle_follow(event)
    end
    client.reply_message(event['replyToken'], { type: 'text', text: "おk" })
  end
end
