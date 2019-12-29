class Subject < ApplicationRecord
  belongs_to :timetable
  has_one :experiment, through: :timetable
  validates :timetable_id, presence: true
  validates :email, presence: true
end
