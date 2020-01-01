FactoryBot.define do
  factory :timetable do
    start_at { "2019-12-19 19:16:35" }
    number_of_subjects { 1 }
    experiment { nil }
  end
end
