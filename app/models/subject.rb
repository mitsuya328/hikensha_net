class Subject < ApplicationRecord
  belongs_to :experiment
  default_scope -> { order(start_at: :asc) }
  validates :experiment_id, presence: true
  validates :start_at, presence: true
end
