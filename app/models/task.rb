class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 40 }
  validates :content, presence: true
  validates :time_limit, presence: true
end
