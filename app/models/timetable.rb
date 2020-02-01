class Timetable < ApplicationRecord
  belongs_to :experiment
  has_many :subjects, dependent: :destroy
  #validates :experiment_id, presence: true
  validates :start_at, presence: true
  validates :number_of_subjects, presence: true

  REGISTRABLE_ATTRIBUTES = %i(id start_at _destroy)

  def selectable?
    subjects.count < number_of_subjects
  end
end
