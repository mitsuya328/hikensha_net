class Subject < ApplicationRecord
  belongs_to :experiment
  default_scope -> { order(start_at: :asc) }
  validates_presence_of :experiment
  validates :start_at, presence: true
end
