class Subject < ApplicationRecord
  belongs_to :timetable
  has_one :experiment, through: :timetable
  validates :timetable_id, presence: true
  validates :email, presence: true
  validate :number_of_subjects

  private
    def number_of_subjects
      unless timetable.subjects.count < timetable.number_of_subjects
        errors[:base] << "その時間の実験は既に満席です"
      end
    end
end
