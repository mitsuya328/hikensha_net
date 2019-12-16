FactoryBot.define do
  factory :subject do
    start_at { "2019-12-16 20:20:26" }
    email { "MyString" }
    sex { "MyString" }
    birth_date { "2019-12-16" }
    note { "MyText" }
    experiment { nil }
  end
end
