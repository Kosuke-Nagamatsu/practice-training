class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 40 }
  validates :content, presence: true
  validate :start_check
  def start_check
    errors.add(:time_limit, "は現在の日時より未来の時間を選択してください") if time_limit < Time.now
  end
end
