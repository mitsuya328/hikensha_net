class Timetable < ApplicationRecord
  belongs_to :experiment
  has_many :subjects, dependent: :destroy
  # validates :experiment_id, presence: true
  # validates :start_at, presence: true

  REGISTRABLE_ATTRIBUTES = %i(id start_at _destroy)
end