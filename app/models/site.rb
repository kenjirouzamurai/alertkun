class Site < ApplicationRecord
  belongs_to :user
  has_many :histories, dependent: :destroy

  validates :name, presence: true
  validates :domain, presence: true
end
