FactoryBot.define do
  factory :subject do
    email { "subject@example.com" }
    sex { "1" }
    birth_date { "2000-1-1" }
    note { nil }
    experiment { nil }
  end
end
