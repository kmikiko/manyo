class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  validates :expired_at, presence: true
  validates :status, presence: true
  scope :search_name, -> (keyword){ where('name LIKE(?)', "%#{keyword}%") }
  scope :search_status, -> (status){ where(status: status) }
end
