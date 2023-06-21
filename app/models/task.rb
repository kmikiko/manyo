class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  validates :expired_at, presence: true
  validates :status, presence: true
  scope :search_name, -> (keyword){ where('name LIKE(?)', "%#{keyword}%") }
  scope :search_status, -> (status){ where(status: status) }
  
  enum priority: { high: 0, middle: 1, low: 2 }
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings, source: :label

end
