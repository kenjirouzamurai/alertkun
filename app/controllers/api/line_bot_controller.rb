class Api::LineBotController < ActionController::API
  require "line/bot"

  def create
    return head :bad_request unless valid_signature?

    line_events.each do |event|
      line_id = event["source"]["userId"]

      case event
      when Line::Bot::Event::Follow # 初回登録時
        if User.exists?(line_id: line_id)
          message = "既に認証済みです。"
        else
          message = "認証のために、登録しているemailを送ってください"
        end

        client.push_message(line_id, format_text(message))
      when Line::Bot::Event::Message # メッセージ受信時
        if user = User.find_by(email: event.message["text"])
          user.update!(line_id: line_id)
          message = "登録が完了しました。"
        else
          message = "メールアドレスが違います"
        end
        client.push_message(line_id, format_text(message))
      end
    end

    head :ok
  end

private

  def line_events
    bot_client = Line::Bot::Client.new
    bot_client.parse_events_from(request.body.read)
  end

  def format_text(text)
    {
      "type": "text",
      "text": text
    }
  end

  def valid_signature?
    client.validate_signature(request.body.read, request.env["HTTP_X_LINE_SIGNATURE"])
  end
  
  def client
    return @client if @client.present?

    @client = Line::Bot::Client.new do |config|
      config.channel_id     = Rails.application.credentials[:line_login_api][:channel_id]
      config.channel_secret = Rails.application.credentials[:line_login_api][:channel_secret]
    end
  end
end
