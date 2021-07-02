class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 40 }
  validates :content, presence: true
  validate :start_check
  def start_check
    errors.add(:time_limit, "は現在より未来の日時を選択してください") if time_limit < Time.now
  end
  enum status: {
    '選択してください':0,
    未着手: 1, 着手中: 2, 完了: 3
  }
  scope :fuzzy_by_title, ->(params) { where('title LIKE ?', "%#{params}%") }
  scope :full_by_status, ->(params) { where(status: params) }
end
