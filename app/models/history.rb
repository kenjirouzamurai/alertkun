class History < ApplicationRecord
  belongs_to :site, touch: true

  scope :last_one_day, -> { where(created_at: 1.days.ago...Time.zone.now) }
  scope :success, -> { where(result: true) }
end
