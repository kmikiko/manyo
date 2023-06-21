class Labelling < ApplicationRecord
  belongs_to :label
  belongs_to :task
  scope :search_label_id, -> (label){ where(label_id: label).pluck(:task_id) }
end
