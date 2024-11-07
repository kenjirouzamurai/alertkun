class SiteDecorator < ApplicationDecorator
  delegate_all

  def result_status
    if histories.exists?
      histories.select(:result).last.result ? "正常" : "異常"
    else
      "ステータス未登録"
    end
  end

  def avg_response_time
    histories.last_one_day.success.select(:response_time).average(:response_time)&.round(2) || 0
  end
end
