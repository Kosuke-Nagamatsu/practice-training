class Task < ApplicationRecord
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  validates :title, presence: true, length: { maximum: 40 }
  validates :content, presence: true
  validate :start_check
  def start_check
    errors.add(:time_limit, "は現在より未来の日時を選択してください") if time_limit < Time.now
    errors.add(:status, "を選択してください") if status == '選択してください'
  end
  enum status: { '選択してください':0, 未着手: 1, 着手中: 2, 完了: 3 }
  enum priority: { 高: 1, 中: 2, 低: 3 }
  scope :fuzzy_by_title, ->(params) { where('title LIKE ?', "%#{params}%") }
  scope :full_by_status, ->(params) { where(status: params) }
end
