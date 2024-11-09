desc "ping開始"
require "open-uri"

namespace :ping do
  task health_check: :environment do
    @client = Line::Bot::Client.new do |config|
      config.channel_id     = Rails.application.credentials[:line_message_api][:channel_id]
      config.channel_secret = Rails.application.credentials[:line_message_api][:channel_secret]
    end

    History.where("created_at < ?", 2.months.ago).destroy_all if rand(100) == 1

    # bundle exec rake ping:health_check
    puts "health_check開始"
    Site.all.each do |site|
      start_time = Time.zone.now
      URI.open(site.domain, { read_timeout: site.timeout }).read
      response_time = Time.zone.now - start_time
      site.histories.create!(result: true, response_time: response_time)

      unless site.histories.second_to_last.result?
        message = {
          "type": "text",
          "text": "#{site.domain} サーバーが復活しました"
        }
        @client.push_message(site.user.line_id, message) if Rails.env.production?
        @client.push_message(User.first.line_id, message)
      end

    rescue StandardError => e
      site.histories.create!(result: false, message: e)
      message = {
        "type": "text",
        "text": "#{site.domain} の読み込みに失敗しました\n #{e}"
      }

      if site.histories.second_to_last.result? && Rails.env.production?
        @client.push_message(site.user.line_id, message)
      end

      puts "失敗"
    end
    puts "health_check終了"
  end
end
