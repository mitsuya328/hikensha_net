class Timetable < ApplicationRecord
  belongs_to :experiment
  has_many :subjects, dependent: :destroy
  #validates :experiment_id, presence: true
  validates :start_at, presence: true
end
