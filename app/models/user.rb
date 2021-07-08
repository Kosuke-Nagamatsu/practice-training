class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  before_update :do_not_update_if_admin_will_be_zero
  before_destroy :do_not_destroy_last_admin
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  enum admin: { あり: true, なし: false }
  private
  def do_not_destroy_last_admin
    if User.where(admin: :true).count == 1
      errors.add :base, '管理者は少なくとも1人は必要です'
      throw :abort
    end
  end
  def do_not_update_if_admin_will_be_zero
    user = User.where(admin: :true)
    if user.count == 1 && self.admin == "なし"
      errors.add :base, '管理者は少なくとも1人は必要です'
      throw :abort
    end
  end
end
