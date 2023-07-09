class User < ApplicationRecord
  before_destroy :if_last_admin_do_not_destroy
  before_update :if_last_admin_do_not_update
  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, length: { minimum: 6 }
  has_many :tasks, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  private

  def if_last_admin_do_not_destroy
    if User.where(admin: true).count == 1 && self.admin == true
      throw(:abort)
    end
  end

  def if_last_admin_do_not_update
    if User.where(admin: true).count == 1 && self.admin == false
      errors.add(:base, "管理者は最低一人必要です")
      throw(:abort)
    end
  end
end
