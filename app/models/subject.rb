class Subject < ApplicationRecord
  belongs_to :timetable
  validates :timetable_id, presence: true
  validates :email, presence: true
end
