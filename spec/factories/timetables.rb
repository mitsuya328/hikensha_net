FactoryBot.define do
  factory :timetable do
    sequence(:start_at) { |n| n.day.after }
    number_of_subjects { 1 }
    experiment { nil }
  end
end