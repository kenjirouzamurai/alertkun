class Company < ApplicationRecord
  has_many :users

  enum plan: { trial: 0, pro: 1 }
end
